class RenameInteractionBasketsToBaskets < ActiveRecord::Migration
  def change
    rename_table :interaction_baskets, :baskets
  end
end
