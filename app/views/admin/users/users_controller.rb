require 'open-uri'

class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def edit
  end

  def update
    attach_avatar_from_url if user_params[:avatar_url].present?

    if @user.update(user_params.except(:avatar_url))
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end
  
  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :full_name,
      :email,
      :role,
      :password,
      :password_confirmation,
      :avatar,
      :avatar_url
    )
  end

  def attach_avatar_from_url
    downloaded_image = URI.open(user_params[:avatar_url])
    @user.avatar.attach(io: downloaded_image, filename: "avatar.jpg")
  end
end