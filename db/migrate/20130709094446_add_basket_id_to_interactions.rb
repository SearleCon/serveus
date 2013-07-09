class AddBasketIdToInteractions < ActiveRecord::Migration
  def change
    add_column :interactions, :basket_id, :integer
  end
end
