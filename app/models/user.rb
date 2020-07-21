class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :phone_number, length: {is: 10}

  #relationships
  has_one :foreman
  has_many :helpers

  #nested form association
  accepts_nested_attributes_for :foreman

  #enum access control
  enum role: [:worker, :boss, :admin]


end
