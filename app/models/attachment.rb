# == Schema Information
#
# Table name: attachments
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#  interaction_id     :integer
#  image_processing   :boolean
#

class Attachment < ActiveRecord::Base

  belongs_to :interaction, touch: true

  #PaperClip
  has_attached_file :local_image, path: "/tmp/images/:id/:filename"
  has_attached_file :image, storage: :s3, path: 'serveus/images/:id/:style/:filename'
  validates_attachment_size :local_image, less_than: 1.megabyte

  before_local_image_post_process :is_image?
  before_image_post_process :is_image?



  before_create :set_name_to_file_name
  after_save :queue_upload_to_s3

  private
  def set_name_to_file_name
     self.name = File.basename(local_image_file_name, ".*") if local_image?
  end

  def is_image?
   image? ? content_type = image_content_type : content_type = local_image_content_type
   image_types.include?(content_type)
  end

  def image_types
    ["image/jpeg", "image/pjpeg", "image/png", "image/x-png", "image/gif"]
  end

  def queue_upload_to_s3
    Delayed::Job.enqueue UploadImageJob.new(self.id) if self.local_image_updated_at_changed?
  end

end