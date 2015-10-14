require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user = User.create!(user_attributes)

describe UsersController do
  context "when signed in" do
    before do
      session[:user_id] = user
    end
    it "redirects to home page if not admin" do
      get :new, id: user
      expect(response).to redirect_to(root_path)
    end
    it "redirects to home page after create" do
      post :create, user: { name: 'Sideshow', email: 'Bob@test.com', password: 'Testing1' }
      expect(response).to redirect_to(root_path)
    end
    it "renders new if create fails" do
      post :create, user: { email: 'Bob@test.com', password: 'Testing1' }
      expect(response).to render_template(:new)
    end
  end
  context "when not signed in" do
    before do
      session[:user_id] = nil
    end
    it "cannot access show" do
      get :show, id: user
      expect(response).to redirect_to(sign_in_path)
    end
    it "cannot access edit" do
      get :edit, id: user
      expect(response).to redirect_to(sign_in_path)
    end
    it "cannot access update" do
      patch :update, id: user
      expect(response).to redirect_to(sign_in_path)
    end
  end
end
