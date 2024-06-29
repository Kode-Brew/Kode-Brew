class SprintLecture < ApplicationRecord
  belongs_to :sprint
  belongs_to :lecture
  belongs_to :user, optional: true

  validates :sprint_id, :lecture, presence: true
end
