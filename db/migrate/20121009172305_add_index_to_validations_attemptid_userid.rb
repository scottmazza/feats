class AddIndexToValidationsAttemptidUserid < ActiveRecord::Migration
  def change
    add_index :validations, :attempt_id
    add_index :validations, :user_id
  end
end
