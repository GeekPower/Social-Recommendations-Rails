class AddUserNameToLinks < ActiveRecord::Migration
  def self.up
    add_column :links, :user_name, :string
  end

  def self.down
    remove_column :links, :user_name
  end
end
