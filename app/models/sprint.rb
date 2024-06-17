class Sprint < ApplicationRecord
  belongs_to :project
  has_many :sprint_lectures # not dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :lectures, through: :sprint_lectures

  validates :objective, :date_start, :date_end, presence: true


end
