class EmailProcessor
  def self.process(email)
    user = User.find_by(email: email.from)
    if user
      ActiveRecord::Base.transaction do
       incident = user.incidents.create!(name: email.subject)
       interaction = incident.interactions.create!(content: email.body)
      end
    end
  end
end