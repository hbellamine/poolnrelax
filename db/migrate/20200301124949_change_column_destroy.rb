class ChangeColumnDestroy < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :destroybyuser, :boolean
  end
end
