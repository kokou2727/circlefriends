class GroupsController < ApplicationController
  before_action :authenticate_user!
  def index
    @side_groups = Group.order("RAND()").limit(12)
  end

  def new
    @side_groups = Group.order("RAND()").limit(12)
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
      @side_groups = Group.order("RAND()").limit(12)
      render :new
    end
  end

  def edit
    @side_groups = Group.order("RAND()").limit(12)
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_chats_path(@group)
    else
      @side_groups = Group.order("RAND()").limit(12)
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

  def invite_index
    @side_groups = Group.order("RAND()").limit(12)
    @group = Group.find(params[:group_id])
  end

  private
  def group_params
    params.require(:group).permit(:group_name, :image, user_ids: [] )
  end
end
