class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  enum role: { user: 0, admin: 1 }
  
  after_initialize :set_default_role, if: :new_record?
  
  def set_default_role
    self.role ||= :user
  end

  has_one_attached :avatar

  attr_accessor :avatar_url

  after_validation :attach_avatar_from_url, if: -> { avatar_url.present? && !avatar.attached? }
  validate :only_one_avatar_source

  private

  def attach_avatar_from_url
    require 'open-uri'

    begin
      downloaded_image = URI.open(avatar_url)
      self.avatar.attach(io: downloaded_image, filename: "avatar.jpg")
    rescue OpenURI::HTTPError, Errno::ENOENT => e
      errors.add(:avatar_url, "não é uma URL de imagem válida")
      Rails.logger.error("Erro ao baixar avatar da URL: #{avatar_url}. Erro: #{e.message}")
    end
  end

  def only_one_avatar_source
    if avatar.present? && avatar_url.present?
      errors.add(:avatar, "não pode ser enviado junto com uma URL. Por favor, escolha apenas um método.")
    end
  end
end
