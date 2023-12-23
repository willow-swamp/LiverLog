class ApplicationController < ActionController::Base
  add_flash_types :success, :warning, :error, :info

  before_action :require_login
  before_action :require_general

  private

  def not_authenticated
      redirect_to main_app.root_path, error: t('defaults.not_authenticated')
  end

  def require_general
    redirect_to group_path(current_user.groups.first), warning: t('defaults.access_denied') unless current_user.general? || current_user.admin?
  end
end
