class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  
  enum role: { user: 0, admin: 1 }
  
  after_initialize :set_default_role, if: :new_record?
  
  def set_default_role
    self.role ||= :user
  end

  has_one_attached :avatar

  attr_accessor :avatar_url

  validate :only_one_avatar_source

  def process_avatar_url
    attach_avatar_from_url
  end

  private

  def attach_avatar_from_url
    require 'open-uri'

    begin
      avatar.purge if avatar.attached?

      downloaded_image = URI.open(avatar_url, read_timeout: 10)
      content_type = downloaded_image.content_type

      unless content_type.start_with?('image/')
        errors.add(:avatar_url, "should be a valid image URL (JPEG, PNG, GIF, etc.)")
        return
      end

      extension = case content_type
                  when 'image/jpeg' then 'jpg'
                  when 'image/png' then 'png'
                  when 'image/gif' then 'gif'
                  when 'image/webp' then 'webp'
                  else 'jpg'
                  end

      filename = "avatar_#{Time.current.to_i}.#{extension}"
      self.avatar.attach(io: downloaded_image, filename: filename, content_type: content_type)

    rescue OpenURI::HTTPError => e
      errors.add(:avatar_url, "could not access the URL. Please check if the URL is correct and accessible.")
      Rails.logger.error("HTTP error while downloading avatar from URL: #{avatar_url}. Status: #{e.message}")
    rescue Errno::ENOENT, SocketError => e
      errors.add(:avatar_url, "invalid or inaccessible URL.")
      Rails.logger.error("Network error while downloading avatar from URL: #{avatar_url}. Error: #{e.message}")
    rescue => e
      errors.add(:avatar_url, "error processing image from URL.")
      Rails.logger.error("Unexpected error while downloading avatar from URL: #{avatar_url}. Error: #{e.message}")
    end
  end

  def only_one_avatar_source
    if avatar.present? && avatar_url.present? && !avatar.attached?
      errors.add(:avatar, "cannot be submitted along with a URL. Please choose only one method.")
    end
  end
end
