class AddNameToFeats < ActiveRecord::Migration
  def change
    add_column :feats, :name, :string
  end
end
