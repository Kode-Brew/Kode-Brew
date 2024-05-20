class User < ApplicationRecord
  has_many :project_members
  has_many :sprint_lectures
  has_many :ticket
  has_many :lectures, trough: :sprint_lectures
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
