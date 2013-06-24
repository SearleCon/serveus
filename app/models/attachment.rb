class Attachment < ActiveRecord::Base
  belongs_to :interaction, touch: true

  before_save :set_name_to_file_name
  after_save :queue_upload_to_s3


  #PaperClip
  has_attached_file :local_image,
                    path: ":rails_root/public/system/:attachment/:id/:style/:basename.:extension",
                    url:  "/system/:attachment/:id/:style/:basename.:extension"

  has_attached_file :image,
                    styles: {large: '500x500#', medium: '200x200#', small: '70x70#'},
                    convert_options: {all: '-strip'},
                    storage:         :s3,
                    path:            "serveus/images/:id/:style/:filename"

  def upload_to_s3
    self.image = self.local_image
    save!
  end

  private
  def set_name_to_file_name
    self.name = File.basename(local_image_file_name, ".*")
  end

  def queue_upload_to_s3
    Delayed::Job.enqueue ImageJob.new(self.id) if local_image? && local_image_updated_at_changed?
  end
end
