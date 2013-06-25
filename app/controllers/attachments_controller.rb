class AttachmentsController < ApplicationController
  expose(:attachment)

  def download
    redirect_to attachment.image.expiring_url(10)
  end
end
