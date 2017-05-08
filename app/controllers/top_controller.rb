require 'Time'
class TopController < ApplicationController

  def index
    if (params[:category].nil? or params[:category]=="all")
      @posts = Post.order("created_at DESC").page(params[:page]).per(15)
    else
      @posts = Post.where('category LIKE(?)',"#{params[:category]}").order("created_at DESC").page(params[:page]).per(15)
    end
  end


end
