class ProfilesController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[show]

  def show
    unless current_user == @user
      redirect_to root_path, alert: "You don't have permission to view this profile." unless current_user&.admin?
    end
  end

  def edit
    redirect_to root_path, alert: "You can only edit your own profile." unless current_user == @user
  end

  def update
    redirect_to root_path, alert: "You can only edit your own profile." unless current_user == @user

    if @user.update(profile_params)
      redirect_to profile_path(@user), notice: "Profile updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user == @user
      sign_out(current_user)
      @user.destroy
      
      redirect_to root_path, notice: "Sua conta foi deletada com sucesso."
    else
      redirect_to profile_path(@user), alert: "Você não tem permissão para deletar esta conta."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def profile_params
    params.require(:user).permit(:full_name, :avatar, :avatar_url, :role, :email)
  end
end