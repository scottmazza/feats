class RemoveAddressFieldsFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :street
    remove_column :locations, :city
    remove_column :locations, :state
    remove_column :locations, :zipcode
  end

  def down
    add_column :locations, :street
    add_column :locations, :city
    add_column :locations, :state
    add_column :locations, :zipcode
  end
end
