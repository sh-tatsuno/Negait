class PostsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @post = Post.new
  end

  #投稿の作成
  def create
    Post.create(create_params)

    #投稿後にタイトルにリダイレクト
    redirect_to controller: :users, action: :show, id: current_user.id
  end

  def confirm
    @user = User.find(params[:user_id])
    @post = Post.new(create_params) # <=POSTされたパラメータを取得
    render :new if @post.invalid? # <=バリデーションチェックNGなら戻す
  end

  def show
    #自分が協力表明をしているかチェック
    #current_user.id : ログインしているサポーターのid
    @support = Support.where('post_id = :post_id and supporter_id = :supporter_id',{post_id: params[:id], supporter_id: current_user.id})

    #自分の投稿を確認
    @post = Post.find(params[:id])

    end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      @post.update(post_params)
    end
    redirect_to action: :show, id: params[:id]
  end

  def complete
    Post.find(params[:id]).update(completed: 1)
    #redirect_to action: :show, id: params[:id]
    @count = Post.all.sum(:completed)
  end

  def destroy
    post = Post.find(params[:id])
    if post.user.id == current_user.id
      post.destroy
      supports = Support.where('post_id = :post_id',{post_id: params[:id]})
      supports.each do |support|
        support.destroy
      end
    end
    redirect_to controller: "users", action: :show, id: current_user.id
  end

private
  #書き込み許可
  def create_params
    params.require(:post).permit(:title, :detail, :category).merge(user_id: current_user.id)
  end

  #ポスト編集許可
  def post_params
    params[:detail] = @post.detail + "\n" + params[:detail]
    params.permit(:detail)
  end

end
