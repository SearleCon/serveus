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

  belongs_to :basket, touch: true
  belongs_to :incident, counter_cache: true, touch: true
  has_many :attachments, dependent: :destroy

  validates  :content, presence: true

  before_validation :init_defaults

  default_scope -> { order(created_at: :desc) }

  scope :unassigned, -> { where(incident_id: nil) }


  def attachments_array=(array)
    array.each { |file| attachments.build(image: file) }
  end

  def contact_info
    "Contacted #{self.contact_person} via #{self.contact_detail}" if self.contact_person?
  end


  private
  def init_defaults
     self.start_at = Time.zone.now if self.start_at.blank?
     self.title = "Interaction#{Time.zone.now.to_s(:default)}"  if self.title.blank?
  end
end
