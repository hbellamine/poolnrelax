class ChangePhotoName < ActiveRecord::Migration[5.2]
  def change
    rename_column :pools, :photo, :picture
  end
end
