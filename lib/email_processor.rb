class EmailProcessor
  def self.process(email)
    user = User.find_by(email: email.from)
    if user
      user.incidents.create(name: email.subject.strip) do |incident|
        incident.interactions.create(content: email.body.strip)
      end
    end
  end
end