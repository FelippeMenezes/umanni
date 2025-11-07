class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin
  
  def show
    @user_stats = UserStats.new
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied. Only administrators can access this area."
    end
  end
end