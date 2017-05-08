class UsersController < ApplicationController

  def show
    current_user.supports.update_all(notification: 0)
    @posts = current_user.posts.order("created_at DESC").page(params[:page]).per(10)
  end

  def edit
    ##編集用
    @user = User.find(current_user.id)
  end

  def update
    ##編集用
    user = User.find(current_user.id)
    user.update(user_params)
    redirect_to controller: "users", action: :profile, id: current_user.id
  end

  def profile
    @user_id = params[:id].to_i
    @user = User.find(@user_id)
  end

  private
  def user_params
    params.require(:user).permit(:image, :nickname, :introduction,:avatar)
  end

end
