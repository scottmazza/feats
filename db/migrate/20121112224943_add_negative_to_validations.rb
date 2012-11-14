class AddNegativeToValidations < ActiveRecord::Migration
  def change
    add_column :validations, :rebuttal, :boolean, default: :false
  end
end
