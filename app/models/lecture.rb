class Lecture < ApplicationRecord
  include PgSearch::Model

  belongs_to :user, optional: true
  validates :title, :video, presence: true

  TAGS = %w[Front-end Back-end Full-stack Javascript CSS Deploy].sort

  pg_search_scope :search_by_title_and_tag,
                  against: %i[title tag],
                  using: {
                    tsearch: { prefix: true }
                  }
end
