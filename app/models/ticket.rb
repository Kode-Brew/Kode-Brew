class Ticket < ApplicationRecord
  # Associations
  belongs_to :task
  belongs_to :user

  # Validations
  validates :status, presence: true
end
