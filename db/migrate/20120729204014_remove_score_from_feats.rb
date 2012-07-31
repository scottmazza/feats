class RemoveScoreFromFeats < ActiveRecord::Migration
  def up
    remove_column :feats, :score
  end

  def down
    add_column :feats, :score
  end
end
