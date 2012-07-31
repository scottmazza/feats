class RemoveCreatorUidFromLocations < ActiveRecord::Migration
  def up
    remove_column :locations, :creator_uid, :integer
  end

  def down
    add_column :locations, :creator_uid, :integer
  end
end
