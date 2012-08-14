class RemoveAddressFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :address
  end

  def down
    add_column :locations, :address
  end
end
