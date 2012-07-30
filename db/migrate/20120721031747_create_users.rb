class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email
      t.string :name
      t.string :username
      t.string :image
      t.string :oath_provider
      t.string :oath_uid

      t.timestamps
    end
  end
end
