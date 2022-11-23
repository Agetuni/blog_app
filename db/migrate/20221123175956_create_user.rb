class CreateUser < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :Name
      t.string :Bio
      t.text :bio
      t.integer :Post_counter
      t.timestamps
    end
  end
end
