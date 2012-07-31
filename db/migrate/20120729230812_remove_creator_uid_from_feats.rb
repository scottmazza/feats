class RemoveCreatorUidFromFeats < ActiveRecord::Migration
  def up
    remove_column :feats, :creator_uid, :integer
  end

  def down
    add_column :feats, :creator_uid, :integer
  end
end
