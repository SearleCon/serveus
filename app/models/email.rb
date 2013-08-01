class Email
  include ActiveModel::Model

  attr_accessor :from, :to, :subject, :body, :cc

  validates :from, :to, :subject, :body, presence: true

end