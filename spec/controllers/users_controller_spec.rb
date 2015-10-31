require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation
DatabaseCleaner.clean

user = User.create!(user_attributes)

describe UsersController do
  context "when signed in" do
    before do
      user.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user.save
      session[:session_token] = user.session_token
    end
    it "shows the current user" do
      get :show, id: user
      expect(response).to render_template(:show)
    end
    it "redirects to root page if signed in user trys the forgot password action" do
      get :forgot
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root page if no email is passed to reset action" do
      post :reset
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root page if email is not found in reset action" do
      post :reset, email: "blue@bluetest.com"
      expect(response).to redirect_to(root_path)
    end
    it "sends an email if email is found in reset action" do
      post :reset, email: "william.wallace@scotland.com"
      expect(assigns(:user).name).to eq("William Wallace")
    end
    it "gets index and redirects to root because not an admin" do
      get :index
      expect(response).to redirect_to(root_path)
    end
    it "gets index if an admin" do
      user3 = User.create!(user_attributes3)
      user3.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user3.save
      session[:session_token] = user3.session_token
      get :index
      expect(response).to render_template(:index)
    end
    it "should update user" do
      patch :update, id: user, user: {:email => "john.doe@example1.com"}
      expect(user.reload.email).to eq("john.doe@example1.com")
    end
    it "should update any user if an admin" do
      user3 = User.find_by(name: "Billy Wallace")
      user3.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user3.save
      session[:session_token] = user3.session_token
      patch :update, id: user, user: {:email => "john.doe@example2.com"}
      expect(user.reload.email).to eq("john.doe@example2.com")
    end
    it "should update any user if an admin and redirect to admin dashboard" do
      user3 = User.find_by(name: "Billy Wallace")
      user3.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user3.save
      session[:session_token] = user3.session_token
      patch :update, id: user, user: {:email => "john.doe@example2.com"}
      expect(response).to redirect_to(users_path)
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
      session[:session_token] = user.session_token
      get :new, id: user
      expect(response).to redirect_to(root_path)
    end
    it "allows admin to add users" do
      user3 = User.find_by(name: "Billy Wallace")
      session[:session_token] = user3.session_token
      get :new, id: user3
      expect(response).to render_template(:new)
    end
    it "redirects to home page after create" do
      post :create, user: { name: 'Sideshow', email: 'Bob@test.com', password: 'Testing1', session_token: 'c86ce2af3d742f2af2a6c5a9740435854a4e051b' }
      expect(response).to redirect_to(root_path)
    end
    it "redirects to home page after create and user is an admin" do
      user2 = User.last
      user2.admin == true
      user2.save
      session[:session_token] = user2.session_token
      post :create, user: { name: 'Sideshow', email: 'Bob2@test.com', password: 'Testing1', session_token: 'c5e04a9936fc4ccc54c71f123739a3f892145208' }
      expect(response).to redirect_to(users_path)
    end
    it "renders new if create fails" do
      post :create, user: { email: 'Bob@test.com', password: 'Testing1' }
      expect(response).to render_template(:new)
    end
    it "deletes a user if admin" do
      user3 = User.create!(user_attributes4)
      user3.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
      user3.save
      session[:session_token] = user3.session_token
      User.create!(user_attributes5)
      post :destroy, id: 68
      expect(response).to redirect_to(users_path)
    end
  end
  context "when not signed in" do
    before do
      session[:user_id] = nil
    end
    it "shows new password view from email" do
      post :reset, email: "billy.wallace@scotland.com"
      get :new_password, token: assigns(:token)
      expect(assigns(:token)).to eq(assigns(:user).reset_token)
    end
    it "redirects to root path if new_password is requested without a token" do
      get :new_password
      expect(response).to redirect_to(root_path)
    end
    it "redirects to root path if new_password is requested with a bad token" do
      get :new_password, token: "1231231"
      expect(response).to redirect_to(root_path)
    end
    it "updates password for user with reset token" do
      post :reset, email: "billy.wallace@scotland.com"
      patch :set_pass, token: assigns(:token), user: {:password => "Testing1", :password_confirmation => "Testing1"}
      expect(response).to redirect_to(root_path)
    end
    it "renders new_password view if password does not match" do
      post :reset, email: "billy.wallace@scotland.com"
      patch :set_pass, token: assigns(:token), user: {:password => "Testing1", :password_confirmation => ""}
      expect(response).to render_template(:new_password)
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
