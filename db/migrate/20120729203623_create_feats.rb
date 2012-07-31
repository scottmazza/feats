class CreateFeats < ActiveRecord::Migration
  def change
    create_table :feats do |t|
      t.integer :location_id
      t.text :description
      t.float :score
      t.boolean :low_score_wins
      t.integer :creator_uid

      t.timestamps
    end
  end
end
