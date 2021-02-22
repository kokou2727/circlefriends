class PostsController < ApplicationController
  def index
    @posts = Post.all.order('created_at DESC')
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    end
  end
end

private

  def post_params
    params.require(:post).permit(:text,:image).merge(user_id: current_user.id)
  end