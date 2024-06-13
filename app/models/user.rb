class User < ApplicationRecord
  has_many :project_members
  has_many :projects, through: :project_members
  has_many :sprint_lectures
  has_many :tasks
  has_many :tickets
  has_one_attached :photo
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
