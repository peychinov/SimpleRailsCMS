class DropTablePages < ActiveRecord::Migration
  def up
  	drop_table :pages
  end

  def down
  	create_table :pages do |t|
      t.string :name
      t.string :title
      t.text :body
      t.date :updated_on
      t.integer :parent_id
      t.integer :position
      t.integer :category_id
      
      t.timestamps
    end
  end
end
