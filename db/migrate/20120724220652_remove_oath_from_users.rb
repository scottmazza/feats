class RemoveOathFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :oath_provider, :string
    remove_column :users, :oath_uid, :string
  end

  def down
    add_column :users, :oath_provider, :string
    add_column :users, :oath_uid, :string
  end
end
