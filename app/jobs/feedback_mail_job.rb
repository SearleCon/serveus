class FeedbackMailJob < Struct.new(:feedback_id)
  def perform
    feedback = Feedback.find(feedback_id)
    FeedbackMailer.notify_support(feedback).deliver
  end
end