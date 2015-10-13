require "rails_helper"
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user = User.create!(user_attributes)
sql = "SELECT setval('users_id_seq', (SELECT max(id) FROM users))"
ActiveRecord::Base.connection.execute(sql)

describe "Signing up" do
  it "prompts for an email and password" do
    visit root_url
    click_link 'Sign Up'
    expect(current_path).to eq(register_path)
    expect(body).to have_field("user_name")
    expect(body).to have_field("user_email")
    expect(body).to have_field("user_password")
  end
  it "signs up if all the fields are correct" do
    visit root_url
    click_link 'Sign Up'
    fill_in "user_name", with: "john.doe"
    fill_in "user_email", with: "john.doe@test.com"
    fill_in "user_password", with: "Testing1"
    fill_in "user_password_confirmation", with: "Testing1"
    click_button 'Sign Up'
    expect(body).to have_text("john.doe")
  end
end
