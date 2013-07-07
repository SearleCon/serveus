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


  #PaperClip
  has_attached_file :image,
                    storage:         :s3,
                    path:            "serveus/images/:id/:style/:filename"

  process_in_background :image


  validates_attachment_size :image, less_than: 1.megabyte


  private
  def set_name_to_file_name
    self.name = File.basename(image_file_name, ".*") if image?
  end

  def destroy_images
    self.image.destroy if self.image?
  end
end
