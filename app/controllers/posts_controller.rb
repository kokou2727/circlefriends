class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @side_groups = Group.order("RAND()").limit(12)
    @posts = Post.all.order('created_at DESC').includes(:user)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end

private

  def post_params
    params.require(:post).permit(:text,:image).merge(user_id: current_user.id)
  end