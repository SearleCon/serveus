class RemoveInteractionIdFromInteractionBaskets < ActiveRecord::Migration
  def change
    remove_column :interaction_baskets, :interaction_id
  end
end
