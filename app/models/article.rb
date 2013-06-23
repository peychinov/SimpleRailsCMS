class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  
  attr_accessible :content, :title, :category_id, :tag_list

  acts_as_taggable

  has_paper_trail

  validates :title, :content, :presence => true

  default_scope :order => 'title ASC'

  include Tire::Model::Search
  include Tire::Model::Callbacks

  mapping do
    indexes :category_id, type: 'integer'
    indexes :tag_names
    indexes :title, boost: 10
    indexes :content
  end

  def self.search(params)
    per_page = params[:per_page] || 5
    # tmp hack
    if params[:keywords].present? || params[:category_id].present? || params[:tag].present?
      tire.search(load: true, per_page: per_page, page: params[:page] || 1) do
        query do
          boolean do
            must { string params[:keywords], default_operator: "AND" } if params[:keywords].present?
            must { term :category_id, params[:category_id] } if params[:category_id].present?
            must { term :tag_names, params[:tag] } if params[:tag].present?
          end
        end
        sort { by :title, 'desc' } if params[:keywords].blank?
      end
    else
      tire.search(load: true, per_page: per_page, page: params[:page] || 1) do
        sort { by :created_at, 'desc' }
      end
    end
  end

  def to_indexed_json
    to_json(methods: [:tag_names])
  end

  def tag_names
    tag_list.join(',')
  end
end
