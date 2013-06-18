class AddInteractionsCountToIncident < ActiveRecord::Migration
  def change
    add_column :incidents, :interactions_count, :integer, default: 0
  end
end
