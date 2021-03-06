class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :parent_id, :title
  validates :title, :presence => true

  has_paper_trail

  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"

  has_many :articles
  has_many :child_categories, :class_name => "Category", :foreign_key => "parent_id"

  before_destroy :disassociate

  default_scope :order => 'title ASC'

  def short_info
    "#{title} (#{articles.count})"
  end

  def articles_count
    articles_count = articles.count

    child_categories.each do |child|
      articles_count += child.articles_count
    end

    articles_count
  end

  def self.children_json(parent_id = nil, categories_ids = nil)
    categories_json = []

    categories = Category.where(parent_id: parent_id.presence)
    categories.each do |category|
      categories_json << category.json_data(categories_ids) if categories_ids.nil? || categories_ids.include?(category.id)
    end

    categories_json
  end

  def self.for_articles(articles)
    categories = []

    articles.each do |article|
      categories << article.category.parents if article.category
    end

    categories.flatten.uniq
  end

  def parents(including_self = true)
    categories = []

    categories << self if including_self
    categories << Category.find(parent_id).parents if parent_id

    categories
  end

  def with_children
    categories = []

    categories << self
    child_categories.each do |child_category|
      categories << child_category.with_children
    end

    categories.flatten.uniq
  end

  def json_data(categories_ids = nil)
    { data: title, attr: { id: id }, children: Category.children_json(id, categories_ids) }
  end

  private

    def disassociate
      self.articles.each do |article|
        article.category = nil
        article.save
      end

      self.child_categories.each do |category|
        category.parent_category = nil
        category.save
      end
    end
end
