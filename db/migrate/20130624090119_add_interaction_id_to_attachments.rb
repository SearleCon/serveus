class AddInteractionIdToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :interaction_id, :integer
  end
end
