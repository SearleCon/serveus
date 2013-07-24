class AddInteractionsCountToBaskets < ActiveRecord::Migration
  def change
    add_column :baskets, :interactions_count, :integer, default: 0
  end
end
