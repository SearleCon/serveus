class ImageJob < Struct.new(:attachment_id)
  def perform
    attachment = Attachment.find attachment_id
    attachment.upload_to_s3
    attachment.local_image.destroy
  end
end