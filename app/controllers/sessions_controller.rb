class SessionsController < ApplicationController
  def create
  	#if user = User.authenticate(params[:email], params[:password])
    if user = User.find_by(name: params[:email]).try(:authenticate, params[:password]) || User.find_by(email: params[:email]).try(:authenticate, params[:password])
      session[:user_id] = user.id
			gflash :success => "Logged in"
   		redirect_to(session[:intended_url] || root_url)
      session[:intended_url] = nil
  	else
  		gflash :now, :warning => "Invalid email/password combination!"
	    render :new
  	end
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :gflash => { :success => "Logged out successfully" }
  end
end
