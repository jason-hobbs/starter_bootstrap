class SessionsController < ApplicationController
	def create
		if user = User.find_by(name: params[:email]).try(:authenticate, params[:password]) || User.find_by(email: params[:email]).try(:authenticate, params[:password])
			user.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
			user.save!
			session[:session_token] = user.session_token
			gflash :success => "Logged in"
			redirect_to(session[:intended_url] || root_url)
			session[:intended_url] = nil
		else
			gflash :now, :warning => "Invalid email/password combination!"
			render :new
		end
	end

	def destroy
		user = User.find_by(session_token: session[:session_token])
		user.session_token = nil
		user.save!
		session[:session_token] = nil
		redirect_to root_url, :gflash => { :success => "Logged out successfully" }
	end
end
