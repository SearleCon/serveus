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

  belongs_to :incident, counter_cache: true

  validates :title, :content, presence: true

  after_initialize :init, if: :new_record?

  default_scope -> { order(created_at: :desc) }

  private
  def init
    self.start_at = Time.current.strftime("%d/%m/%Y %H:%M:%S %p")
    self.target_date = Time.current.strftime("%d/%m/%Y %H:%M:%S %p")
  end
end
