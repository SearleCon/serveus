class EmailProcessor

  def initialize(email)
    @to = pick_meaningful_recipient(email.to)
    @from = email.from
    @body = email.body
  end

  def self.process(email)
    Rails.logger.log email.subject
  end

  private

  def pick_meaningful_recipient(recipients)
    recipients.find { |address| address =~ /@cloudmailin.net$/ }
  end
end