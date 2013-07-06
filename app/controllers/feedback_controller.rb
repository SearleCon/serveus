class FeedbackController < ApplicationController
  respond_to :html
  expose(:feedback, attributes: :feedback_params)


  def create
    feedback.save
    respond_with(feedback, location: root_url)
  end

  private
  def feedback_params
    params.require(:feedback).permit(:subject, :comment)
  end
end
