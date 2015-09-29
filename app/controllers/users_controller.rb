class UsersController < ApplicationController

  def new
    if current_user
      redirect_to @user, notice: "already signed in!"
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
  	  session[:user_id] = @user.id
    	redirect_to @user, notice: "Thanks for signing up!"
    else
    	render :new
    end
  end

	def edit
  		@user = User.find(params[:id])
      @feeds = Feed.order(:title)
	end

	def update
  	@user = User.find(params[:id])
    @feeds = Feed.all
		if @user.update(user_params)
    	redirect_to @user, notice: "Account successfully updated!"
  	else
    	render :edit
  	end
	end

  private

	def user_params
  	  params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def require_correct_user
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user)
  end

  def require_correct_user_or_admin
      @user = User.find(params[:id])
      redirect_to root_url unless current_user?(@user) || current_user_admin?
  end
end
