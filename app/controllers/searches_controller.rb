class SearchesController < ApplicationController
  def index
    @posts = Post.where(['text LIKE ?', "%#{params[:search]}%"]).order(created_at: :desc)
    @search_result = "#{params[:search]}"
  end

  def search_name
    @name_users = User.where(['name LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end

  def search_job
    @job_users = User.where(['job LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end

  def search_group
    @groups = Group.where(['group_name LIKE ?', "%#{params[:search]}%"])
    @search_result = "#{params[:search]}"
  end
end
