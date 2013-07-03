class EmailProcessor
  def initialize(email)
    @from = email.from
    @body = email.body
  end

  def self.process(email)
  end
end