class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show, :following, :followers]

  def show
    @user = User.find(params[:id])
    @new_replaypost = current_user.replayposts.build
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 9)
  end

  def following
    @title = "フォロー中"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page], per_page: 15)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page], per_page: 15)
    render 'show_follow'
  end
end
