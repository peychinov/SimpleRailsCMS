class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  
  attr_accessible :content, :title, :category_id

  has_paper_trail

  validates :title, :content, :presence => true

  default_scope :order => 'title ASC'

  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(params)
    tire.search(load: true, per_page: 3, page: params[:page] || 1) do
      query { string params[:query]} if params[:query].present?
      sort { by :title, 'desc' }
    end
  end
end
