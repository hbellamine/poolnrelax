class AddColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :destroybyuser, :boolean
  end
end
