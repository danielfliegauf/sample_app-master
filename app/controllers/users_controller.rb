class UsersController < ApplicationController
  before_filter :signed_in_user
  # before_filter :signed_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  # before_filter :admin_user, only: :destroy
	
  def show
		@user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def new #deprecated
  	@user = User.new
  end

  def create #deprecated!
  	@user = User.new(params[:user])
  	if @user.save
 
      sign_in @user
      redirect_to @user
      flash[:success] = "Welcome to Connectify!"
  	else
  		render 'new'
  	end
  end

  def edit #deprecated!
    #@user = User.find(params[:id]) #GIBTS SCHON IN correct_user before_filter!!
  end

  def update
    #@user = User.find(params[:id]) #GIBTS SCHON IN correct_user before_filter!!
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def destroy
    # super
    # session[:user_id] = nil
    # reset_session
    sleep 1
    
    if token = current_user.oauth_token
       reset_session
      sleep 3
      User.find(params[:id]).destroy
      #redirect_to "https://www.facebook.com/logout.php?access_token=" + token + "&next=http%3A%2F%2Flocalhost:3000"
       redirect_to "https://www.facebook.com/logout.php?access_token=" + token + "&next=https%3A%2F%2Fconnectify.herokuapp.com%2F"
    else
    flash[:success] = "User destroyed."
    redirect_to root_path
  end
  end

def following
  @title = "Following"
  @user = User.find(params[:id])
  @users = @user.followed_users.paginate(page: params[:page])
  render 'show_follow'
end

def followers
  @title = "Followers"
  @user = User.find(params[:id])
  @users = @user.followers.paginate(page: params[:page])
  render 'show_follow'
end

 private

    

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end

 

end
