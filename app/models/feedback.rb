class Feedback < ActiveRecord::Base
  validates :subject, :comment, presence: true

  after_commit :notify_support, on: :create

  private
  def notify_support
    FeedbackMailer.delay.notify_support(self) if persisted?
  end
end
