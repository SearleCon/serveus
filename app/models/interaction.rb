# == Schema Information
#
# Table name: interactions
#
#  id             :integer          not null, primary key
#  title          :string(255)
#  content        :text
#  start_at       :datetime
#  contact_person :string(255)
#  contact_detail :string(255)
#  target_date    :datetime
#  incident_id    :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Interaction < ActiveRecord::Base
  include Taggable

  belongs_to :incident, counter_cache: true, touch: true

  validates :title, :content, presence: true

  after_initialize :init, if: :new_record?
  after_save :queue_upload_to_s3

  default_scope -> { order(created_at: :desc) }

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
  def init
    self.start_at = Time.current.strftime("%d/%m/%Y %H:%M:%S %p")
  end

  def queue_upload_to_s3
    Delayed::Job.enqueue ImageJob.new(self.id) if local_image? && local_image_updated_at_changed?
  end
end
