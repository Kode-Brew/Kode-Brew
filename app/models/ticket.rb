class Ticket < ApplicationRecord
  enum category: {
    Backend: 0,
    FrontEnd: 1,
    FullStack: 2,
    Deploy: 3
  }
  # Associations
  belongs_to :task
  belongs_to :user, optional: true

  # Validations
  validates :status, presence: true
end
