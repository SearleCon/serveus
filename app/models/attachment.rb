# == Schema Information
#
# Table name: attachments
#
#  id                       :integer          not null, primary key
#  name                     :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#  local_image_file_name    :string(255)
#  local_image_content_type :string(255)
#  local_image_file_size    :integer
#  local_image_updated_at   :datetime
#  image_file_name          :string(255)
#  image_content_type       :string(255)
#  image_file_size          :integer
#  image_updated_at         :datetime
#  interaction_id           :integer
#

class Attachment < ActiveRecord::Base
  belongs_to :interaction, touch: true

  before_create :set_name_to_file_name
  before_destroy :destroy_images
  after_save :queue_upload_to_s3


  #PaperClip
  has_attached_file :local_image,
                    path: ":rails_root/public/system/:attachment/:id/:style/:basename.:extension",
                    url:  "/system/:attachment/:id/:style/:basename.:extension"

  has_attached_file :image,
                    convert_options: {all: '-strip'},
                    storage:         :s3,
                    path:            "serveus/images/:id/:style/:filename"


  validates_attachment_size :local_image, less_than: 1.megabyte

  def upload_to_s3
    self.image = self.local_image
    save!
  end

  private
  def set_name_to_file_name
    self.name = File.basename(local_image_file_name, ".*") if local_image?
  end

  def destroy_images
    self.image.destroy if self.image?
    self.local_image.destroy if self.local_image?
  end

  def queue_upload_to_s3
    Delayed::Job.enqueue ImageJob.new(self.id) if local_image? && local_image_updated_at_changed?
  end
end
