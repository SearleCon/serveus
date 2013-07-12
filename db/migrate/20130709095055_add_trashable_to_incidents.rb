class AddTrashableToIncidents < ActiveRecord::Migration
  def change
   add_column :incidents, :trashed, :boolean, default: false
  end
end