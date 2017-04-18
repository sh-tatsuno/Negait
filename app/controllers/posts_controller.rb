class PostsController < ApplicationController
def new
  @user = User.find(params[:user_id])
  @post = Post.new
end

#投稿の作成
def create
  Post.create(create_params)

  #投稿後にタイトルにリダイレクト
  redirect_to controller: :top, action: :index
end

def show
  #自分に協力する人がいるかチェック
  @supports = Support.where('post_id = :post_id',{post_id: params[:id]})

  #自分の投稿を確認
  @post = Post.find(params[:id])
end

def edit
end

def destroy
  post = Post.find(params[:id])
  #if post.user_id == current_user.id
    post.destroy
  #end
  redirect_to controller: :top, action: :index
end

private
#書き込み許可
def create_params
  params.require(:post).permit(:title, :detail).merge(user_id: current_user.id)
end

end
