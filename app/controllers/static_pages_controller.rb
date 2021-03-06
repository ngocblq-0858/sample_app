class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = User.feed(current_user).paginate(page: params[:page])
    end
  end

  def help; end

  def about; end

  def contact; end
end
