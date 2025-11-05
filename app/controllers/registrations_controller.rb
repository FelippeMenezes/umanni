class RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      if resource.persisted? && params[:user][:avatar_url].present?
        resource.avatar_url = params[:user][:avatar_url]
        resource.process_avatar_url
        resource.save
      end
    end
  end

  private

  def sign_up_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :avatar, :avatar_url)
  end

  def account_update_params
    params.require(:user).permit(:full_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_url)
  end
end