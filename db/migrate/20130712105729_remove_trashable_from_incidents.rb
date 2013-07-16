class RemoveTrashableFromIncidents < ActiveRecord::Migration
  def change
    remove_column :incidents, :trashed
  end
end
