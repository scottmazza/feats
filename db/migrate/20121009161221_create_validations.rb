class CreateValidations < ActiveRecord::Migration
  def change
    create_table :validations do |t|
      t.integer :attempt_id
      t.integer :user_id
      t.text :comment

      t.timestamps
    end
  end
end
