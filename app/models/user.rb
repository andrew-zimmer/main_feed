class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validations
  validates :first_name, presence: true
  validates :last_name, presence: true

  #relationships
  has_one :foreman
  has_many :helpers

  #enum access control
  enum role: [:worker, :boss, :admin]


end
