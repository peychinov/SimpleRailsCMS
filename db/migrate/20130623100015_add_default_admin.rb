class AddDefaultAdmin < ActiveRecord::Migration
  def up
    Admin.new({ email: 'admin@admin.com', password: '123456', password_confirmation: '123456' }).save
  end

  def down
    Admin.find_by_email('admin@admin.com').delete
  end
end
