class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  
  def index
    @users = User.all.order(created_at: :desc)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user.save
      redirect_to admin_users_path, notice: "Usuário criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Acesso negado. Apenas administradores podem acessar esta área."
    end
  end

  def user_params
    # Process role parameter from toggle first
    if params[:user][:role] == "admin" || params[:user][:role] == true || params[:user][:role] == "1"
      params[:user][:role] = "admin"
    else
      params[:user][:role] = "user"
    end
    
    params.require(:user).permit(:email, :full_name, :role, :password, :password_confirmation)
  end
end