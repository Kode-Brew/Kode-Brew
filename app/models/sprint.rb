class Sprint < ApplicationRecord
  belongs_to :projects
  has_many :sprint_lectures # not dependent: :destroy
end
