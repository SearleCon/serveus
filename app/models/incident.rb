# == Schema Information
#
# Table name: incidents
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  open       :boolean
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Incident < ActiveRecord::Base
  belongs_to :user
  has_many :interactions, -> { includes :tags }

  validates :name, presence: true
  validates :user, presence: true

  default_scope -> { where(open: true) }


  def to_param
    "#{id}-#{name.parameterize}"
  end

end
