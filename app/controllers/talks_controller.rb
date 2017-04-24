class TalksController < ApplicationController
  def index
    @talks = Talk.where('support_id = :support_id', {support_id: params[:support_id]})
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @support = Support.find(params[:support_id])
    @talk = Talk.new
  end

  def create
    Talk.create(create_params)
    @talks = Talk.where('support_id = :support_id', {support_id: params[:support_id]})
  end

  private
  def create_params
    if current_user.id == params[:user_id]
      poster_or_supporter = 0
    else
      poster_or_supporter = 1
    end
    params.require(:talk).permit(:support_id, :talk, :poster_or_supporter).merge({support_id: params[:support_id], poster_or_supporter: poster_or_supporter})
  end

end
