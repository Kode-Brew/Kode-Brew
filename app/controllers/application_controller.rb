class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper :breadcrumbs
  include BreadcrumbsHelper
  before_action :set_default_breadcrumbs

  protected

  def set_default_breadcrumbs
    add_breadcrumb "Início", root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role points linkedin github photo])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name role points linkedin github photo])
  end

  private

  def authenticate_admin
    unless current_user&.is_admin
      redirect_to root_path, alert: 'Você não está autorizado a acessar esta página.'
    end
  end
end
