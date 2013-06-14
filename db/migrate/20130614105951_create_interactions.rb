class CreateInteractions < ActiveRecord::Migration
  def change
    create_table :interactions do |t|
      t.string :title
      t.text :content
      t.datetime :start_at
      t.string :contact_person
      t.string :contact_detail
      t.datetime :target_date
      t.references :incident

      t.timestamps
    end
  end
end
