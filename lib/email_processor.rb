class EmailProcessor


  def initialize(email)
    @from = email.from
    @body = email.body
  end


  def self.process(email)
   User.last.touch
  end


  private

  def pick_meaningful_recipient(recipients)
    recipients.find { |address| address =~ /@mydomain.com$/ }
  end
end