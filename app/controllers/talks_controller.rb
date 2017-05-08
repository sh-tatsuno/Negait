class TalksController < ApplicationController
  def index
    @talks = Talk.where('support_id = :support_id', {support_id: params[:support_id]})
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @support = Support.find(params[:support_id])
    @talk = Talk.new
  end

  def create
    if current_user.id == params[:user_id].to_i
      poster_or_supporter = 0
    else
      poster_or_supporter = 1
    end
    Talk.create(create_params(poster_or_supporter))
    @talks = Talk.where('support_id = :support_id', {support_id: params[:support_id]})
    support = Support.find(params[:support_id])
    if (poster_or_supporter == 1)
      support.update(notification: 1)
    end
  end

  private
  def create_params(poster_or_supporter)
    params.require(:talk).permit(:support_id, :talk, :poster_or_supporter,:user_id).merge({support_id: params[:support_id], poster_or_supporter: poster_or_supporter, user_id: current_user.id})
  end

end
