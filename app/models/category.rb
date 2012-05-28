class Category < ActiveRecord::Base
  attr_accessible :parent_id, :title

  has_many :articles  
  has_many :child_categories, :class_name => "Category"
  
  belongs_to :parent_category, :class_name => "Category", :foreign_key => "parent_id"
end
