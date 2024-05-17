class Project < ApplicationRecord
  belongs_to :client
  has_many :member_project

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true
end
