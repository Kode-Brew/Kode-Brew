class Lecture < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :source, :video, :slide, presence: true

  TAGS = %w[Front-end Back-end Full-stack Javascript CSS Deploy].sort
end
