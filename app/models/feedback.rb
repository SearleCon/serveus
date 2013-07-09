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

  after_commit :notify_support, on: :create

  private
  def notify_support
    FeedbackMailer.delay.notify_support(self) if persisted?
  end
end
