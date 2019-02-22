class StaticPagesController < ApplicationController
  def home
    @user = User.new
    if user_signed_in?
      @feed_items = current_user.feed.paginate(page: params[:page], per_page: 5)
      @new_replaypost = current_user.replayposts.build
    end
  end
end
