class CreateInteractionBasket < ActiveRecord::Migration
  def change
    create_table :interaction_baskets do |t|
      t.integer :interaction_id
      t.integer :user_id
      t.boolean :assigned, default: false
    end
  end
end
