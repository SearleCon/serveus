class FeedbackMailJob < Struct.new(:feedback_id)
  def perform
    feedback = Feedback.find(feedback_id)
    FeedbackMailer.deliver_notify_support(feedback)
  end
end