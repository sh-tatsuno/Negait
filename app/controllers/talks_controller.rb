class TalksController < ApplicationController
  def index
    #binding.pry
    @talks = Talk.where('support_id = :support_id', {support_id: params[:support_id]})
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @support = Support.find(params[:support_id])

    ##サポートのリセット
    if current_user.id == params[:user_id].to_i
      @support.update(poster_notification: 0)
    else
      @support.update(supporter_notification: 0)
    end
    #@support.update(notification: 0)

    #ユーザー・サポーターのid
    @poster = User.find(@support.user_id)
    @supporter = User.find(@support.supporter_id)

    @talk = Talk.new
    gon.watch.talks = @talks
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

    if (poster_or_supporter == 0)
      user = User.find(support.supporter_id)
      support.update(supporter_notification: 1)
      user.update(ring: 1)

    elsif (poster_or_supporter == 1)
      support.update(poster_notification: 1)
      support.post.user.update(ring: 1)
    end
  end

  private
  def create_params(poster_or_supporter)
    params.require(:talk).permit(:support_id, :talk, :poster_or_supporter,:user_id).merge({support_id: params[:support_id], poster_or_supporter: poster_or_supporter, user_id: current_user.id})
  end

end
