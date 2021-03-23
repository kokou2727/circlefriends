class SearchesController < ApplicationController
  def index
    @side_groups = Group.order("RAND()").limit(12)
    @posts = Post.where(['text LIKE ?', "%#{params[:search]}%"]).order(created_at: :desc)
    @search_result = "#{params[:search]}"
  end

  def search_name
    @side_groups = Group.order("RAND()").limit(12)
    @name_users = User.where(['name LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end

  def search_job
    @side_groups = Group.order("RAND()").limit(12)
    @job_users = User.where(['job LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end

  def search_group
    @side_groups = Group.order("RAND()").limit(12)
    @groups = Group.where(['group_name LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end
end
