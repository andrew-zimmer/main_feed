class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true

end
