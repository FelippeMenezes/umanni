class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :avatar

  # Atributo virtual para receber a URL da imagem
  attr_accessor :avatar_url

  before_validation :attach_avatar_from_url

  private

  def attach_avatar_from_url
    return if avatar_url.blank?
    return if avatar.attached?

    require 'open-uri'

    begin
      downloaded_image = URI.open(avatar_url)
      self.avatar.attach(io: downloaded_image, filename: "avatar.jpg")
    rescue OpenURI::HTTPError, Errno::ENOENT => e
      errors.add(:avatar_url, "não é uma URL de imagem válida")
      Rails.logger.error("Erro ao baixar avatar da URL: #{avatar_url}. Erro: #{e.message}")
    end
  end
end
