class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @side_groups = Group.order("RAND()").limit(12)
    @posts = Post.order('created_at DESC').limit(20).includes(:user).page(params[:page]).per(20)
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
    else
      redirect_to root_path
    end
  end
end

private

  def post_params
    params.require(:post).permit(:text,:image).merge(user_id: current_user.id)
  end