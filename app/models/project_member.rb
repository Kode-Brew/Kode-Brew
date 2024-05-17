class ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :ticket
  has_many :task
end
