class RemoveAttachmentsFromInteractions < ActiveRecord::Migration
  def change
    remove_attachment :interactions, :local_image
    remove_attachment :interactions, :image
  end
end
