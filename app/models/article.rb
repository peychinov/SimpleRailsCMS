class Article < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :category
  
  attr_accessible :content, :title, :category_id

  validates :title, :content, :presence => true
end
