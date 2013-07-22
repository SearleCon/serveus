class AddLocalImageToAttachments < ActiveRecord::Migration
  def change
    add_attachment :attachments, :local_image
  end
end
