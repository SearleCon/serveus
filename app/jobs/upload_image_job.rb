class UploadImageJob < Struct.new(:attachment_id)
  def perform
    attachment = Attachment.find(attachment_id)
    attachment.image = attachment.local_image
    attachment.local_image = nil
    attachment.save!
  end
end