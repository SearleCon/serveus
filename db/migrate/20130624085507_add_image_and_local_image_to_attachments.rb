class AddImageAndLocalImageToAttachments < ActiveRecord::Migration
  def change
    add_attachment :attachments, :local_image
    add_attachment :attachments, :image
  end
end
