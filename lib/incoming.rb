class EmailReceiver < Incoming::Strategies::Postmark
  def receive(mail)
    puts %(Got message from #{mail.to.first} with subject "#{mail.subject}")
  end
end
