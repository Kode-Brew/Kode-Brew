class Project < ApplicationRecord
  belongs_to :client
  has_many :project_member
  has_many :sprints, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true
end
