class UserMailer < ActionMailer::Base
  default from: "fmiunivbuc@gmail.com"

  def notification_email(from_mail, to_mail, subject, text)
    @text = text
    mail(from: from_mail, to: to_mail, subject: subject)
  end
end
