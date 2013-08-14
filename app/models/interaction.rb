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
#  basket_id      :integer
#

class Interaction < ActiveRecord::Base
  include Taggable

  belongs_to :basket, counter_cache: true, touch: true
  belongs_to :incident, counter_cache: true, touch: true
  has_many :attachments, dependent: :destroy

  accepts_nested_attributes_for :attachments, reject_if: :all_blank, allow_destroy: true

  validates  :content, presence: true

  before_validation :init_defaults

  default_scope -> { order(created_at: :desc) }

  scope :unassigned, -> { where(incident: nil) }
  scope :targeted, -> { where.not(target_date: nil) }

  private
  def init_defaults
     self.occurred = Time.zone.now if self.occurred.blank?
     self.title = Time.zone.now.to_s(:default) if self.title.blank?
  end
end
