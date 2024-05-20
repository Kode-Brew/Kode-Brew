class Lecture < ApplicationRecord
  validates :title, :source, :video, :slide, presence: true
  belongs_to :user
end
