class AddTrashedTo<%= model_name.tableize.upcase %> < ActiveRecord::Migration
  def change
   add_column :<%=model_name.tableize %>, :trashed, :boolean, default: false
  end
end