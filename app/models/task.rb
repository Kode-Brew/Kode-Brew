class Task < ApplicationRecord
  # Associations
  belongs_to :sprint
  belongs_to :user
  has_many :tickets, dependent: :destroy

  # Validations
  validates :name, :priority, :description, :status, :points, presence: true
  validates :description, length: { maximum: 300 }
  validates :points, numericality: { greater_than: 0 }
end
