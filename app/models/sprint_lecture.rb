class SprintLecture < ApplicationRecord
  belongs_to :sprint
  belongs_to :lecture
  belongs_to :project_member
end
