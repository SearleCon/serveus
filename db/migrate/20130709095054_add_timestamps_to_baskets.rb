class AddTimestampsToBaskets < ActiveRecord::Migration
  def change
    change_table :baskets do |t|
      t.timestamps
    end
  end
end
