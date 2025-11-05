class PagesController < ApplicationController
  def home
    if user_signed_in?
      if current_user.admin?
        redirect_to admin_dashboard_path
      elsif current_user.user?
        redirect_to profile_path(current_user)
      end
    end
  end
end
