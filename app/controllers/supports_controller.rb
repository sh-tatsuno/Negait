class SupportsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @support = Support.new
  end

  def create
    Support.create(create_params)
    redirect_to action: :index
  end

  def index
    @supports = Support.where('post_id = :post_id', {post_id: params[:post_id]})
  end

  private
  def create_params
    params.require(:support).permit(:supporter_id, :post_id, :message).merge({supporter_id: current_user.id, post_id: params[:post_id]})
  end
end