class MicropostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :show, :create, :destory]
  before_action :correct_user, only: :destroy

  def new
    @micropost = current_user.microposts.build
  end

  def show
    @micropost = current_user.microposts.build
    if @current_post = Micropost.find_by(id: params[:id])
      @user = User.find_by(id: @current_post.user_id)
      @replayposts =
        Micropost.where(replay_id: params[:id]).paginate(page: params[:page], per_page: 5)
    else
      render 'static_pages/home'
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @current_post = Micropost.find_by(id: @micropost.replay_id)
    if @micropost.save
      flash[:notice] = "正常にコメントされました"
      if @micropost.replay_id.nil?
        redirect_to current_user
      else
        redirect_to @current_post
      end
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "コメントは正常に削除されました"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:picture, :content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.nil?
      flash[:alert] = "エラーが発生しました。写真が選択されているか確認してください"
      redirect_to home_url
    end
  end
end
