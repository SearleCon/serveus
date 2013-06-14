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

  belongs_to :incident

  validates :title, :content, presence: true

  after_initialize :init, if: :new_record?

  private
  def init
    self.start_at = Time.zone.now
  end
end
