class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :parent_id, :title
  has_paper_trail

  before_destroy :disassociate

  has_many :articles
  has_many :child_categories, :class_name => "Category", :foreign_key => "parent_id"

  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"

  validates :title, :presence => true

  default_scope :order => 'title ASC'

  def short_info
    "#{title} (#{articles.count})"
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
