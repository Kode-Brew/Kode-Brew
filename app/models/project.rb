class Project < ApplicationRecord
  belongs_to :client
  has_many :member_project
  has_many :sprints

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true
end
