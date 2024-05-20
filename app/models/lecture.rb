class Lecture < ApplicationRecord
  validates :title, :source, :video, :slide, presence: true
end
