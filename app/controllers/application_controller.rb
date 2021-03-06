class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def require_signin
    unless current_user
      session[:intended_url] = request.url
      redirect_to sign_in_url, alert: "Please sign in first!"
    end
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token]) if session[:session_token]
    rescue ActiveRecord::RecordNotFound
  end

  helper_method :current_user

  def current_user?(user)
    current_user == user
  end

  helper_method :current_user?

  def require_admin
    unless current_user_admin?
      redirect_to root_url, alert: "Unauthorized access!"
    end
  end

  def current_user_admin?
    current_user && current_user.admin?
  end

  helper_method :current_user_admin?

  def get_user
    if session[:session_token]
      @user = current_user
    end
  end

  helper_method :get_user

  def require_correct_user_or_admin
    @user = User.friendly.find(params[:id])
    redirect_to root_url unless current_user?(@user) || current_user_admin?
  end

  helper_method :require_correct_user_or_admin

end
