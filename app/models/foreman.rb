class Foreman < ApplicationRecord
  validates :user_id, presence: true

  belongs_to :user
  has_many :helpers

  accepts_nested_attributes_for :user, allow_destroy: true

  def full_name
    "#{self.user.first_name} #{self.user.last_name}"
  end

  def email
    user.email
  end

  def phone_number
    user.phone_number
  end

  def users_badges
    user.users_badges
  end

  def self.current_foreman
    self.find_by(id: params[:id])
  end

  def self.sort_by_name
    self.joins(:user).order(:first_name)
  end


end
