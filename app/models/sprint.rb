class Sprint < ApplicationRecord
  belongs_to :project
  has_many :sprint_lectures # not dependent: :destroy
end
