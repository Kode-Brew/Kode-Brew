class Client < ApplicationRecord
  has_many :projects
  has_one_attached :photo

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Formato de e-mail inválido" }

  VALID_PHONE_REGEX = /\A\d{10,11}\z/
  validates :cell_phone, presence: true, format: { with: VALID_PHONE_REGEX,
                                                   message: "formato inválido. Use (XX)XXXXXXX" }

  CATEGORIES = %w[Startup Administração Marketplace Finanças Cultura Lazer Outros].sort
end
