class RemoveAssignedFromBaskets < ActiveRecord::Migration
  def change
    remove_column :baskets, :assigned
  end
end
