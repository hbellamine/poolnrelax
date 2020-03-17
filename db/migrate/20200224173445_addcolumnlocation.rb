class Addcolumnlocation < ActiveRecord::Migration[5.2]
  def change
    add_column :pools, :location, :string
  end
end
