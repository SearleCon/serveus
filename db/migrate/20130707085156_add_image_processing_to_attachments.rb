class AddImageProcessingToAttachments < ActiveRecord::Migration
  def change
    add_column :attachments, :image_processing, :boolean
  end
end
