class PagesController < ApplicationController
  def home
    if user_signed_in? && current_user.user?
      redirect_to profile_path(current_user)
    end
  end
end
