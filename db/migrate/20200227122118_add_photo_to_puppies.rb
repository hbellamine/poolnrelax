class AddPhotoToPuppies < ActiveRecord::Migration[5.2]
  def change
    add_column :pools, :photo, :string
  end
end
