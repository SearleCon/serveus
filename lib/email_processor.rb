class EmailProcessor
  def self.process(mail)
   ActiveRecord::Base.transaction do
     user = User.find_by(email: mail.from.downcase)
     if user
      user.create_basket! unless user.basket
      user.basket.interactions.create!(title: mail.subject, content: mail.body)
     end
   end
  end
end