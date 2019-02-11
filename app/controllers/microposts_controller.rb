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
    else
      render 'static_pages/home'
    end
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "写真がシェアされました"
      redirect_to current_user
    else
      @feed_items = []
      flash[:alert] = "投稿に失敗しました。画像が選択されているか確認してください"
      redirect_to current_user
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "投稿は正常に削除されました"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:picture, :content, :replay_id)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    if @micropost.nil?
      flash[:alert] = "エラーが発生しました"
      redirect_to root_url
    end
  end
end
