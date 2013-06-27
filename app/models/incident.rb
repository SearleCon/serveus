# == Schema Information
#
# Table name: incidents
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  open               :boolean
#  user_id            :integer
#  created_at         :datetime
#  updated_at         :datetime
#  interactions_count :integer          default(0)
#

class Incident < ActiveRecord::Base
  belongs_to :user
  has_many :interactions,-> { includes :attachments, :tags },dependent: :destroy

  validates :name, presence: true
  validates :user, presence: true

  scope :open, -> { where(open: true) }
  scope :closed, -> { where(open: false) }

  after_initialize :init

  def to_s
   self.name.titleize
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  def tag_cloud
   interactions.map(&:tag_names).uniq.flatten
  end

  private
  def init
    if new_record?
     self.open = true
    end
  end

end
