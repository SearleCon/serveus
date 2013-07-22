class AttachmentsController < ApplicationController
  expose(:attachment)

  def download
    if attachment.image?
     redirect_to attachment.image.expiring_url(10)
    else
     redirect_to attachment.local_image.url
    end
  end
end
