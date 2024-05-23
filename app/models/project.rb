class Project < ApplicationRecord
  belongs_to :client
  has_many :project_members
  has_many :sprints
  has_many :tasks, through: :sprints

  validates :name, presence: true, uniqueness: true
  validates :category, :description, presence: true


  #
  def date_end_project
    sprints.maximum(:date_end)
  end

  def date_start_project
    sprints.minimum(:date_start)
  end

  def status
    if (date_end_project || Time.now.next_day(1)) > Time.now
      if (date_start_project || Time.now.next_day(1)) < Time.now
        "Em andamento"
      else
        "não iniciado"
      end
    else
      "finilizado"
    end
  end
end
