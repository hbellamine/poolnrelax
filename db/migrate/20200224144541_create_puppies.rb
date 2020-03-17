class CreatePuppies < ActiveRecord::Migration[5.2]
  def change
    create_table :pools do |t|
      t.string :name
      t.integer :nbpeople
      t.string :option
      t.integer :price
      t.boolean :availability
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
