class Category < ActiveRecord::Base
  attr_accessible :parent_id, :title

  has_many :pages
end
