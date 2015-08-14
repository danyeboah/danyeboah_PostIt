class AddUserTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_status, :string
  end
end
