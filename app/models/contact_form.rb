class ContactForm < MailForm::Base
  attributes :name,  validate: true
  attributes :email, validate: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attributes :message
  attribute :nickname,  captcha: true



  def headers
    {
      subject: "My Contact Form",
      to: "support@searleconsulting.co.za",
      from: %("#{name}" <#{email}>)
    }
  end

end