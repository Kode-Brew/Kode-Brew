class Project < ApplicationRecord
  enum status: { Pendente: 0, Iniciado: 1, Finalizado: 2 }

  belongs_to :client
  has_many :project_members, dependent: :destroy
  has_many :sprints, dependent: :destroy
  has_many :tasks, through: :sprints
  has_many :users, through: :project_members
  has_many :tasks, through: :sprints
  has_many :sprint_lectures, through: :sprints
  has_many :lectures, through: :sprint_lectures

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true

  accepts_nested_attributes_for :project_members

  # Métodos
  def date_end_project
    sprints.maximum(:date_end)
  end

  def date_start_project
    sprints.minimum(:date_start)
  end

  def total_sprints
    sprints.count
  end

  def available_lectures
    Lecture.where.not(id: lectures.pluck(:id))
  end

  # Calcula os pontos totais de todas as tarefas finalizadas para um membro específico do projeto
  def total_points_for_member(user)
    project_members
      .where(user: user)
      .joins(project: { sprints: :tasks })
      .where(tasks: { status: 'Finalizada' })
      .sum('tasks.points')
  end

  # Calcula os pontos totais de todas as tarefas finalizadas para um membro específico do projeto
  def total_task_finish_for_member(user)
    project_members
      .where(user: user)
      .joins(project: { sprints: :tasks })
      .where(tasks: { status: 'Finalizada' })
      .count
  end
end
