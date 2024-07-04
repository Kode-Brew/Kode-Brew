class ProjectMember < ApplicationRecord
  enum user_type: {
    Aluno: 0,
    Professor: 1,
    TA: 2,
  }

  # Associations
  belongs_to :user
  belongs_to :project
  has_many :tickets
  has_many :tasks
  has_many :lectures, through: :sprint_lectures

  # Validations
  validates :user_id, uniqueness: { scope: :project_id, message: "já está alocado no projeto" }

  # Calcula os pontos totais das tarefas finalizadas para o membro do projeto
  def total_points
      user.tasks
           .joins(:sprint)
           .where(sprints: { project_id: project.id }, tasks: { status: 'Finalizada' })
           .sum(:points)
  end
end
