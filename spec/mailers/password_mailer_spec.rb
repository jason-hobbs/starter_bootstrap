require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
  describe "password_mail" do
    user = User.first
    token = "1123123123123123"
    let(:mail) { PasswordMailer.password_mail(token, user) }

    it "renders the headers" do
      expect(mail.subject).to eq("Starter-bootstrap password reset")
      expect(mail.to).to eq(["william.wallace@scotland.com"])
      expect(mail.from).to eq(["from@starter-bootstrap.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include("A password reset was triggered at starter-bootstrap for your account.")
    end
  end

end
