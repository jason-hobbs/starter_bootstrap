require 'rails_helper'

describe User do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:email)}
  it "wipes out all reset_tokens" do
    user = User.first
    user.reset_token = 123123123123123
    user.save!
    User.clear_reset_tokens
    User.find_each do |user|
      expect(user.reset_token).to eq(nil)
    end
  end
end
