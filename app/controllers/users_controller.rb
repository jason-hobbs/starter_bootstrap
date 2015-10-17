class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create]
  before_action :require_correct_user_or_admin, only: [:edit, :show, :update]
  before_action :require_admin, only: [:index, :destroy]

  def index
    @user = User.find(session[:user_id])
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
  	@user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      unless current_user_admin?
  	    session[:user_id] = @user.id
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
  	@user = User.find(params[:id])
  	@user.destroy
    redirect_to users_path
	end

	def update
  	@user = User.find(params[:id])
		if @user.update(user_params)
    	redirect_to @user, :gflash => { :success => "Account updated!" }
  	else
    	render :edit
  	end
	end

  private

	def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

  def require_correct_user_or_admin
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user) || current_user_admin?
  end
end
