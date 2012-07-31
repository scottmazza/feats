class AddIndexToFeatsLocationIdCreatorUid < ActiveRecord::Migration
  def change
    add_index :feats, :location_id
    add_index :feats, :creator_uid
  end
end
