class Project < ApplicationRecord
  belongs_to :client
  has_many :project_members
  has_many :sprints
  has_many :tasks, through: :sprints
  has_many :users, through: :project_members

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true

  #
  def date_end_project
    sprints.maximum(:date_end)
  end

  def date_start_project
    sprints.minimum(:date_start)
  end

  def total_sprints
    sprints.count
  end

  # def status
  #   if (date_end_project || Time.now.next_day(1)) > Time.now
  #     if (date_start_project || Time.now.next_day(1)) < Time.now
  #       "Em andamento"
  #     else
  #       "não iniciado"
  #     end
  #   else
  #     "finalizado"
  #   end
  # end

  enum status: { Pendente: 0, Iniciado: 1, Finalizado: 2 }

  # Calcula os pontos totais de todas as tarefas finalizadas para um membro específico do projeto
  def total_points_for_member(user)
    project_members
      .where(user: user)
      .joins(project: { sprints: :tasks })
      .where(tasks: { status: 'finalizada' })
      .sum('tasks.points')
  end
end
