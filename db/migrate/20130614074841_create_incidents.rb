class CreateIncidents < ActiveRecord::Migration
  def change
    create_table :incidents do |t|
      t.string :name
      t.boolean :open

      t.references :user


      t.timestamps
    end
  end
end
