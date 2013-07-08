class RemoveLocalImageFromAttachments < ActiveRecord::Migration
  def change
    remove_attachment :attachments, :local_image
  end
end
