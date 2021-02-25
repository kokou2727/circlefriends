class GroupsController < ApplicationController
  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path
  end

  private
  def group_params
    params.require(:group).permit(:group_name, user_ids: [] )
  end
end
