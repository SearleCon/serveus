class RenameStartAtToOccurred < ActiveRecord::Migration
  def change
    rename_column :interactions, :start_at, :occurred
  end
end
