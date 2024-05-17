class Project < ApplicationRecord
  belongs_to :client

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true
end
