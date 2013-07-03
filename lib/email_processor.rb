class EmailProcessor
  def self.process(email)
      ActiveRecord::Base.transaction do
        user = User.find_by!(email: email.from)
        if user
         incident = user.incidents.create!(name: email.subject)
         incident.interactions.create!(content: email.body)
        end
      end
  end
end
