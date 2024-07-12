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

  validate :user_id_cannot_be_equal_to_task_user_id

  private

  def user_id_cannot_be_equal_to_task_user_id
    if user_id.present? && task.present? && user_id == task.user_id
      errors.add(:user_id, 'não pode assumir sua própria task')
    end
  end
end
