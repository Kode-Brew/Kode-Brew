class ProjectMember < ApplicationRecord
  belongs_to :user
  belongs_to :project
  has_many :tickets
  has_many :tasks
end
