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
  has_many :attachments, dependent: :destroy

  validates :title, :content, presence: true

  after_initialize :init, if: :new_record?

  default_scope -> { order(created_at: :desc) }


  def attachments_array=(array)
    array.each { |file| attachments.build(local_image: file) }
  end

  def contact_info
    "Contacted #{self.contact_person} via #{self.contact_detail}" if self.contact_person?
  end

  private
  def init
    self.start_at = Time.zone.now.strftime("%d/%m/%Y %H:%M:%S %p")
    self.title = "Interaction#{Time.zone.now.strftime("%d/%m/%Y %H:%M:%S %p")}"
  end
end
