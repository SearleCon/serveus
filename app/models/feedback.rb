# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  subject    :string(255)
#  comment    :text
#  created_at :datetime
#  updated_at :datetime
#

class Feedback < ActiveRecord::Base
  validates :subject, :comment, presence: true
end
