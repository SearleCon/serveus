class AddIndexesToForeignKeys < ActiveRecord::Migration
  def change
   add_index :attachments, :interaction_id
   add_index :incidents, :user_id
   add_index :interactions, :incident_id
   add_index :tags, :user_id
   add_index :taggings, :tag_id
   add_index :taggings, [:taggable_id, :taggable_type]
  end
end
