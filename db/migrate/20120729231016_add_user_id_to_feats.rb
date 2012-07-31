class AddUserIdToFeats < ActiveRecord::Migration
  def change
    add_column :feats, :user_id, :integer
  end
end
