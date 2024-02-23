class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :error, :info

  before_action :require_login
  before_action :require_general
  before_action :require_first_login

  rescue_from CanCan::AccessDenied do |_exception|
    redirect_to main_app.root_path, error: '画面を閲覧する権限がありません。'
  end

  private

  def not_authenticated
    redirect_to main_app.root_path, error: t('defaults.not_authenticated')
  end

  def require_general
    return if current_user.general? || current_user.admin?

    redirect_to group_path(current_user.groups.first),
                warning: t('defaults.access_denied')
  end

  def require_first_login
    return unless current_user.first_login

    if current_user.invitee?
      redirect_to invitees_invitation_first_login_path
    else
      redirect_to first_login_path
    end
  end
end
