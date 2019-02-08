class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:id])
    @new_micropost  = current_user.microposts.build
    @microposts = @user.microposts.paginate(page: params[:page], per_page: 9)
  end
end
