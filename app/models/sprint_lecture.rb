class SprintLecture < ApplicationRecord
  belongs_to :sprint
  belongs_to :lecture

  validates :sprint_id, :lecture, presence: true
end
