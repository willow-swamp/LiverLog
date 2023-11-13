class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  skip_before_action :require_general, only: %i[show]

  def new
    @group = current_user.groups.new
  end

  def create
    @group = current_user.groups.new(group_params)
    @group.set_invite_token
    # binding.pry
    if @group.save
      @group.save_group_member(current_user)
      redirect_to profile_path, success: t('.success')
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
      redirect_to profile_path, success: t('.success')
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
