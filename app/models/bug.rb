class Bug < ApplicationRecord
  # Connections to the Project and Users
  belongs_to :project
  belongs_to :creator, class_name: "User", foreign_key: "creator_id"
  belongs_to :assignee, class_name: "User", foreign_key: "assignee_id", optional: true

  # Validations to keep our data clean
  validates :title, presence: true
  validates :status, presence: true

  # Custom validation to ensure status is only one of these allowed options
  validates :status, inclusion: { in: %w[New Started Resolved], message: "%{value} is not a valid status" }
end
