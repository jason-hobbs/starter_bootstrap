class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create, :forgot, :reset, :new_password, :set_pass]
  before_action :require_correct_user_or_admin, only: [:edit, :show, :update]
  before_action :require_admin, only: [:index, :destroy]

  def index
    @user = User.find_by(session_token: session[:session_token])
    @users = User.all.order(:name)
  end

  def new
    if current_user
      unless current_user_admin?
        redirect_to root_path, :gflash => { :notice => "Already signed in!" }
      else
        @user=User.new
      end
    else
      @user=User.new
    end
  end

  def show
    @user = User.friendly.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    @user.session_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    if @user.save
      unless current_user_admin?
        session[:session_token] = @user.session_token
        redirect_to root_path, :gflash => { :success => "Thanks for signing up!" }
      else
        redirect_to users_path
      end
    else
      render :new
    end
  end

  def edit
  end

  def destroy
    @user = User.friendly.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  def update
    @user = User.friendly.find(params[:id])
    if @user.update(user_params)
      if current_user_admin? && @user != @current_user
        redirect_to users_path, :gflash => { :success => "Account updated!" }
      else
        redirect_to @current_user, :gflash => { :success => "Account updated!" }
      end
    else
      render :edit
    end
  end

  def forgot
    if current_user
      redirect_to root_path
    end
  end

  def reset
    @user = User.find_by(email: params[:email])
    if @user
      @token = Digest::SHA1.hexdigest([Time.now, rand].join)
      @user.update_column(:reset_token, @token)
      PasswordMailer.password_mail(@token, @user).deliver_now
      redirect_to sign_in_path, :gflash => { :success => "New password email sent" }
    else
      redirect_to root_path
    end
  end

  def new_password
    unless params[:token]
      return redirect_to root_path
    else
      @user = User.find_by(reset_token: params[:token])
      unless @user
        return redirect_to root_path
      else
        @token = params[:token]
      end
    end
  end

  def set_pass
    @user = User.find_by(reset_token: params[:token])
    @token = params[:token]
    if @user.update(user_params)
      @user.update_column(:reset_token, nil)
      session[:session_token] = @user.session_token
      redirect_to root_path, :gflash => { :success => "Account updated!" }
    else
      render :new_password, token: @token
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin, :reset_token)
  end

end
