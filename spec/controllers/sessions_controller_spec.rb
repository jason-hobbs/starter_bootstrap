require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user = User.create!(user_attributes)
describe SessionsController do
  context "when signed in" do
    before do
      session[:session_token] = user.session_token
    end
    it "logs user out" do
      delete :destroy, id: user
      expect(response).to redirect_to(root_path)
    end
  end
end
