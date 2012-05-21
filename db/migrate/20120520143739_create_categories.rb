class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.parent_id :integer
      
      t.timestamps
    end
  end
end
