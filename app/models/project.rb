class Project < ApplicationRecord
  has_many :tasks, dependent: :destroy
  # belongs_to :user
  has_many :project_users 
  has_many :users, through: :project_users

  has_many :managers
 
  validates :name, presence: true
  validates :description, presence: true
end
