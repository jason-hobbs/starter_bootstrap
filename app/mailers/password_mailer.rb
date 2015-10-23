class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.password_mail.subject
  #
  def password_mail(token, user)
    @token = token
    @user = user

    mail to: @user.email, subject: "Starter-bootstrap password reset"

  end
end
