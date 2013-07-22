class AttachmentsController < ApplicationController
  expose(:attachment)

  def download
    redirect_to attachment.image.expiring_url(10) if attachment.image?
  end
end
