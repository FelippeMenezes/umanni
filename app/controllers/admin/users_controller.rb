class Admin::UsersController < ApplicationController
  require 'csv'
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

  def import_form
  end

  def download_example
    send_file(
      Rails.root.join('db', 'example_users.csv'),
      filename: 'example_users.csv',
      type: 'text/csv'
    )
  end

  def import
    file = params[:file]
    
    unless file
      redirect_to import_form_admin_users_path, alert: "No file uploaded."
      return
    end
    
    unless file.content_type == "text/csv"
      redirect_to import_form_admin_users_path, alert: "Please upload a valid CSV file."
      return
    end

    success_count = 0
    error_messages = []
    line_number = 1

    begin
      CSV.foreach(file.path, headers: true, encoding: 'utf-8') do |row|
        line_number += 1
        
        unless row["email"].present? && row["full_name"].present?
          error_messages << "Line #{line_number} - e-mail and full name are required."
          next
        end
        
        user_params = {
          email: row["email"].strip,
          full_name: row["full_name"].strip,
          role: validate_role(row["role"])
        }
        
        if row["password"].present?
          user_params[:password] = row["password"]
          user_params[:password_confirmation] = row["password"]
        else
          user_params[:password] = SecureRandom.hex(8)
          user_params[:password_confirmation] = user_params[:password]
        end
        
        user = User.new(user_params)
        
        if user.save
          success_count += 1
        else
          error_messages << "Line #{line_number} - #{user.errors.full_messages.join(', ')}"
        end
      end

      success_message = "#{success_count} user#{'s' if success_count != 1} imported#{'s' if success_count != 1} successfully."

      if error_messages.any?
        redirect_to admin_users_path, 
          notice: success_message, 
          alert: error_messages.join("<br>").html_safe
      else
        redirect_to admin_users_path, notice: success_message
      end
      
    rescue CSV::MalformedCSVError => e
      redirect_to import_form_admin_users_path, 
        alert: "Error processing CSV file: #{e.message}"
    rescue => e
      Rails.logger.error("Error during import: #{e.message}")
      redirect_to import_form_admin_users_path, 
        alert: "Unexpected error during import. Please check the file format."
    end
  end
  
  private
  
  def validate_role(role_value)
    return "user" unless role_value.present?
    
    role_str = role_value.to_s.downcase.strip
    case role_str
    when "admin", "1", "true"
      "admin"
    when "user", "0", "false", ""
      "user"
    else
      "user"
    end
  end

  private

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access denied. Only administrators can access this area."
      return
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