class AddTimedToFeats < ActiveRecord::Migration
  def change
    add_column :feats, :timed, :boolean
  end
end
