class ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :tickets
  has_many :tasks
  has_many :lectures, through: :sprint_lectures

end
