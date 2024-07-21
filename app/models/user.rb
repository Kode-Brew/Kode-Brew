class User < ApplicationRecord
  has_many :project_members
  has_many :projects, through: :project_members
  has_many :sprint_lectures
  has_many :tasks
  has_many :teacher_tickets, class_name: 'Ticket'
  has_many :student_tickets, through: :tasks, source: :tickets
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Método da view de "Projeto atual"
  def project_show_path(project_id)
    project = projects.find_by(id: project_id)
    if project
      Rails.application.routes.url_helpers.project_path(project)
    else
      nil
    end
  end
end
