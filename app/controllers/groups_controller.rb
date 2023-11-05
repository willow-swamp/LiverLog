class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    # binding.pry
    if @group.save
      @group.save_group_member(current_user)
      redirect_to group_path, success: t('.success')
    else
      flash.now[:error] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    @group.assign_attributes(group_params)
    if @group.save
      redirect_to group_path, success: t('.success')
    else
      flash.now[:error] = t('.error')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @group.destroy!
    redirect_to profile_path, success: t('.success')
  end

  private

  def group_params
    params.require(:group).permit(:name, :group_admin_id)
  end

  def set_group
    @group = current_user.groups.find(params[:id])
  end
end
