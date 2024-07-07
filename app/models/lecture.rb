class Lecture < ApplicationRecord
  belongs_to :user, optional: true
  validates :title, :source, :video, :slide, presence: true
end
