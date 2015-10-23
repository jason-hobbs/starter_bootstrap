require "rails_helper"

RSpec.describe PasswordMailer, type: :mailer do
  describe "password_mail" do
    let(:mail) { PasswordMailer.password_mail }

    it "renders the headers" do
      expect(mail.subject).to eq("Password mail")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
