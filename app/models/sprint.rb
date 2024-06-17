class Sprint < ApplicationRecord
  belongs_to :project
  has_many :sprint_lectures # not dependent: :destroy
  has_many :tasks, dependent: :destroy
  has_many :lectures, through: :sprint_lectures

  before_validation :set_date_end
  validates :objective, :date_start, :date_end, presence: true

  validate :date_start_after_previous_sprint

  private

  def set_date_end
    self.date_end = date_start + 6.days if date_start
  end

  def date_start_after_previous_sprint
    if date_start && project
      previous_sprint = project.sprints.where("date_end < ?", date_start).order(date_end: :desc).first
      if previous_sprint && date_start <= previous_sprint.date_end
        errors.add(:date_start, "A data de início da nova Sprint deve ser posterior a #{previous_sprint.date_end.strftime("%d/%m/%Y")}.")
      end
    end
  end
end
