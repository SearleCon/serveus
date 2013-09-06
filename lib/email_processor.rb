class EmailProcessor
  def self.process(mail)
   ActiveRecord::Base.transaction do
     user = User.find_by(email: mail.from.downcase)
     if user
      basket = Basket.find_or_create_by!(user: user)
      basket.interactions.create!(title: mail.subject, content: mail.body)
     end
   end
  end
end