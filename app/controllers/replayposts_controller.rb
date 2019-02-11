class ReplaypostsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destory]
  before_action :correct_user, only: :destroy

  def create
    @replaypost = current_user.replayposts.build(replaypost_params)
    if @replaypost.save
      flash[:notice] = "正常にコメントされました"
      redirect_to current_user
    else
      flash[:alert] = "投稿に失敗しました"
      redirect_to current_user
    end
  end

  def destroy
    @replaypost.destroy
    flash[:notice] = "コメントは正常に削除されました"
    redirect_to request.referrer || root_url
  end

  private

  def replaypost_params
    params.require(:replaypost).permit(:content, :micropost_id)
  end

  def correct_user
    @replaypost = current_user.replayposts.find_by(id: params[:id])
    if @replaypost.nil?
      flash[:alert] = "エラーが発生しました"
      redirect_to root_url
    end
  end
end
