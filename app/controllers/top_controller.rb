class TopController < ApplicationController

  #attributeの分岐を作成
  def index
    if (params[:attribute]=="available")
      if (params[:category].nil? or params[:category]=="all")
        @posts = Post.where('user_id != :user_id', {user_id: current_user.id}).where('completed = 0 and created_at > :limits', {limits: Time.now - 14 * (60*60*24)}).order("created_at DESC").page(params[:page]).per(15)
      else
        @posts = Post.where('user_id != :user_id', {user_id: current_user.id}).where('category LIKE(?)',"#{params[:category]}").where('completed = 0 and created_at > :limits', {limits: Time.now - 14 * (60*60*24)}).order("created_at DESC").page(params[:page]).per(15)
      end
    else
      if (params[:category].nil? or params[:category]=="all")
        @posts = Post.where('user_id != :user_id', {user_id: current_user.id}).order("created_at DESC").page(params[:page]).per(15)
      else
        @posts = Post.where('user_id != :user_id', {user_id: current_user.id}).where('category LIKE(?)',"#{params[:category]}").order("created_at DESC").page(params[:page]).per(15)
      end
    end
  end


end
#where('completed = 0 and created_at < :limits', {limits: Time.now - 14 * (60*60*24)}).