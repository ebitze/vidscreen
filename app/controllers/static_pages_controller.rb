class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @vidpost = current_user.vidposts.build
      @feed_items = current_user.feed.paginate(page: params[:page]).per_page(5)
    end
  end

  def help
  end

  def watch
  end

  def contact
  end

  def faq 
  end
end
