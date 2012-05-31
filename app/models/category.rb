class Category < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: :slugged

  attr_accessible :parent_id, :title

  has_many :articles  
  has_many :child_categories, :class_name => "Category", :foreign_key => "parent_id"
  
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"

  validates :title, :presence => true

  default_scope :order => 'title ASC'
end
