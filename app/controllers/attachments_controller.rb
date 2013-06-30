class AttachmentsController < ApplicationController
  expose(:attachment)

  def download
    if attachment.image?
      redirect_to attachment.image.expiring_url(10)
    else
      send_file attachment.local_image.path, type: attachment.local_image_content_type, disposition: 'inline'
    end
  end
end
