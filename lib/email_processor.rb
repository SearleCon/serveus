class EmailProcessor


  def initialize(email)
    @from = email.from
    @body = email.body
  end


  def self.process(email)
    user = User.find_by(email: email.from)
    incident = user.incidents.find(email.subject)
    incident.interactions.create(content: email.body)
  end
end