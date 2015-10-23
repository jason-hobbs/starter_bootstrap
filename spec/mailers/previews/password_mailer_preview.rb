# Preview all emails at http://localhost:3000/rails/mailers/password_mailer
class PasswordMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/password_mailer/password_mail
  def password_mail
    user = User.first
    token = "1234567890"
    PasswordMailer.password_mail(token, user)
  end

end
