class ContactMailer < ActionMailer::Base
  default to: 'edward@jam.es'
  def contact_email(name, email, body)
    @name = name
    @email = email
    @body = body
    mail(from: email, subject: 'Contact Form Message')
end