class SupportsController < ApplicationController
  def new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @support = Support.new
  end

  def create
    #supportの生成
    Support.create(create_params)
    @support_instance = Support.where('post_id = :post_id and supporter_id = :supporter_id', {post_id: params[:post_id], supporter_id: current_user.id})[0]

    #binding.pry
    #初期トークの生成
    Talk.create(support_id: @support_instance.id, poster_or_supporter: 1, talk: @support_instance[:message])
    #生成したサポートからトークの取り出し
    #redirect_to user_post_support_talks_path({user_id: params[:user_id],post_id: params[:post_id],support_id: support_instance.id})
    redirect_to :controller => "talks", :action => "index", :support_id => @support_instance.id
  end

  private
  def create_params
    params.require(:support).permit(:supporter_id, :post_id, :message).merge({supporter_id: current_user.id, post_id: params[:post_id]})
  end

end