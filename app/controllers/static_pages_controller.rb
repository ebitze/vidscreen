class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @vidpost = current_user.vidposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  def help
  end

  def contact
  end

  def faq 
  end
end
