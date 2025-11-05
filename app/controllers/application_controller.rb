class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name, :avatar, :avatar_url])
    devise_parameter_sanitizer.permit(:account_update, keys: [:full_name, :avatar, :avatar_url])
  end

  def after_sign_in_path_for(resource)
    if resource.admin?
      root_path
    else
      profile_path(resource.id)
    end
  end

  def after_sign_up_path_for(resource)
    if resource.admin?
      root_path
    else
      profile_path(resource.id)
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
end
