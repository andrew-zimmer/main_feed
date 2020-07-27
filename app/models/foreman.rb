class Foreman < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user
  has_many :helpers

  accepts_nested_attributes_for :user, allow_destroy: true

  def full_name
    "#{self.user.first_name} #{self.user.last_name}"
  end
end
