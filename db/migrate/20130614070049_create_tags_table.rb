class CreateTagsTable < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :names
      t.timestamps
    end
  end
end
