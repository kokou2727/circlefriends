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
      group_user = GroupUser.find_by(user_id: current_user.id, group_id: @group.id)
      group_user.update(permit: true)
      redirect_to group_chats_path(@group)
    else
      render :new
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_chats_path(@group)
    else
      render :edit
    end
  end

  def show
    @group = Group.find(params[:id])
    gon.group_name = @group.group_name
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    redirect_to root_path
  end

  private
  def group_params
    params.require(:group).permit(:group_name, :image, user_ids: [] )
  end
end
