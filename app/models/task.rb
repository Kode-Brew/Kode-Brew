class Task < ApplicationRecord
  # Associations
  belongs_to :sprint
  belongs_to :user
  has_many :tickets, dependent: :destroy

  # Validations
  #  validates :farm_id, :name, :size, :capacity, presence: true
end
