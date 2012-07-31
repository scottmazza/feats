class AddIndexToAttemptsFeatIdUserId < ActiveRecord::Migration
  def change
    add_index :attempts, :feat_id
    add_index :attempts, :user_id
  end
end
