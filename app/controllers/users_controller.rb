class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:destroy, :index, :edit, :update, :following, :followers]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy
  
  def new
    @user = User.new
  end

  def edit
  end

  def get_feed_item
    count = current_user.feed.count
    @feed_item_id = current_user.feed[(params[:feed_item_id].to_i) % count].vid_id

    respond_to do |format|
      format.text { render text: @feed_item_id}
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_url
  end

  def update
    if @user.update_attributes(params[:user]) 
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def delete
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
    @vidposts = @user.vidposts.paginate(page: params[:page]).per_page(5)
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Your Vidscreen is active."
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
