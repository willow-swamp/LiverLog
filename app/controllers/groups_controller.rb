class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authorize_group, only: %i[show edit update destroy]
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
      redirect_to group_path(@group), success: t('.success')
    else
      flash.now[:error] = t('.error')
      render :new, status: :unprocessable_entity
    end
  end

  def show
    start_date = params.fetch(:start_time, Date.today).to_date
    drink_records = @group.group_admin.drink_records.all
    @display_records = drink_records.where(id: drink_records.group(:start_time).select('MIN(id)'))
    @admin_user = @group.group_admin
  end

  def edit; end

  def update
    @group.assign_attributes(group_params)
    if @group.save
      redirect_to group_path(@group), success: t('.success')
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
    @group = Group.find(params[:id])
  end

  def authorize_group
    return if @group.users.exists?(current_user.id)

    redirect_to group_path(current_user.groups.first),
                warning: t('defaults.access_denied')
  end
end
