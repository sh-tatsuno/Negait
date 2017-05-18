class UsersController < ApplicationController

  def show
    #showにアクセスしたらそのユーザーの部分の通知を外す
    current_user.update(ring: 0)

    @posts = current_user.posts.order("created_at DESC")

    #自分が協力した投稿
    @supports = Support.where('supporter_id = :supporter_id', {supporter_id: current_user.id}).order("created_at DESC")

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
    params.require(:user).permit(:image, :nickname, :introduction,:avatar,:work)
  end

end
