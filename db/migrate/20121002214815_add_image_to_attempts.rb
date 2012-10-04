class AddImageToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :image, :string
  end
end
