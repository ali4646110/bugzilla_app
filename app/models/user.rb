class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  # Custom Many-to-Many connection to Projects
  has_many :project_users, dependent: :destroy
  has_many :projects, through: :project_users

  # Connections to Bugs (A user can create many bugs or be assigned to many bugs)
  has_many :created_bugs, class_name: "Bug", foreign_key: "creator_id", dependent: :destroy
  has_many :assigned_bugs, class_name: "Bug", foreign_key: "assignee_id", dependent: :nullify

  # Validation to make sure every user has a proper role
  validates :user_type, presence: true
end
