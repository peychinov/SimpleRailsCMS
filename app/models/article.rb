class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  
  attr_accessible :content, :title, :category_id

  has_paper_trail

  validates :title, :content, :presence => true

  default_scope :order => 'title ASC'
end
