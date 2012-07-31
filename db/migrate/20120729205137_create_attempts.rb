class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :feat_id
      t.integer :user_id
      t.float :score
      t.string :video_url

      t.timestamps
    end
  end
end
