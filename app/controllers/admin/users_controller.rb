class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  before_action :set_user, only: [:edit, :update, :delete]
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    if User.where(role: 'admin').count <= 1
      redirect_to admin_users_path, alert: "You cannot delete your own account as the last administrator."
      return
    else
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted successfully."
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied. Only administrators can access this area."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if params[:user].key?(:role)
      if params[:user][:role] == "admin" || params[:user][:role] == true || params[:user][:role] == "1"
        params[:user][:role] = "admin"
      else
        params[:user][:role] = "user"
      end
    else
      params[:user][:role] = "user"
    end
    
    permitted_params = [:email, :full_name, :role]
    
    permitted_params << :password if params[:user][:password].present?
    permitted_params << :password_confirmation if params[:user][:password_confirmation].present?
    
    params.require(:user).permit(*permitted_params)
  end
end