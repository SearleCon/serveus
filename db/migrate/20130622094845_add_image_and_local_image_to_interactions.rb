class AddImageAndLocalImageToInteractions < ActiveRecord::Migration
  def change
    add_attachment :interactions, :local_image
    add_attachment :interactions, :image

  end
end
