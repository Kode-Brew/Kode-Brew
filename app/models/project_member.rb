class ProjectMember < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :project
  has_many :tickets
  has_many :tasks
  has_many :lectures, through: :sprint_lectures

  # Validations
  validates :user_id, uniqueness: { scope: :project_id, message: "já está alocado no projeto" }
end
