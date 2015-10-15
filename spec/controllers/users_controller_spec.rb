require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user = User.create!(user_attributes)

describe UsersController do
  context "when signed in" do
    before do
      session[:user_id] = user.id
    end
    it "shows the current user" do
      get :show, id: user
      expect(response).to render_template(:show)
    end
    it "gets index and redirects to root because not an admin" do
      get :index
      expect(response).to redirect_to(root_path)
    end
    it "get index if an admin" do
      user3 = User.create!(user_attributes3)
      session[:user_id] = user3.id
      get :index
      expect(response).to render_template(:index)
    end
    it "should update user" do
      patch :update, id: user, user: {:email => "john.doe@example1.com"}
      expect(user.reload.email).to eq("john.doe@example1.com")
    end
    it "should not update user when email is blank" do
      patch :update, id: user, user: {:email => ""}
      expect(response).to render_template(:edit)
    end
    it "edits the current user" do
      get :edit, id: user
      expect(response).to render_template(:edit)
    end
    it "redirects when editing a different user and not admin" do
      user2 = User.create!(user_attributes2)
      get :edit, id: user2
      expect(response).to redirect_to(root_path)
    end
    it "redirects to home page if not admin" do
      get :new, id: user
      expect(response).to redirect_to(root_path)
    end
    it "redirects to home page after create" do
      post :create, user: { name: 'Sideshow', email: 'Bob@test.com', password: 'Testing1' }
      expect(response).to redirect_to(root_path)
    end
    it "redirects to home page after create and user is an admin" do
      user2 = User.last
      user2.admin == true
      user2.save
      session[:user_id] = user2
      post :create, user: { name: 'Sideshow', email: 'Bob2@test.com', password: 'Testing1' }
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
