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
  has_attached_file :image, storage: :s3, path: 'serveus/images/:id/:style/:filename'
  validates_attachment_size :image, less_than: 1.megabyte


  before_create :set_name_to_file_name

  private
  def set_name_to_file_name
     self.name = File.basename(image_file_name, ".*") if image?
  end


end