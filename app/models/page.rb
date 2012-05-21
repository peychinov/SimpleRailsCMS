class Page < ActiveRecord::Base
  acts_as_tree :order	=> :position
  acts_as_list :scope => :parent_id
	
  attr_accessible :body, :name, :parent_id, :position, :title, :updated_on, :category_id

  belongs_to :category
end
