class VidpostsController < ApplicationController
  before_filter :signed_in_user, only: [:create, :destroy]
  before_filter :correct_user, only: :destroy

  def index
  end

  def create
    @vidpost = current_user.vidposts.build(params[:vidpost])
    if @vidpost.save
      flash[:success] = "Video posted!"
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @vidpost.destroy
    redirect_to root_url
  end

  private
    def correct_user
      @vidpost= current_user.vidposts.find_by_id(params[:id])
      redirect_to root_url if @vidpost.nil?
    end
end
