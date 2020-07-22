class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: %i[google_oauth2]

  #validations
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true
  validates :phone_number, numericality: true,  length: {is: 10}, :allow_nil => true

  #relationships
  has_one :foreman
  has_many :helpers

  #nested form association
  accepts_nested_attributes_for :foreman

  #enum access control
  enum role: [:worker, :boss, :admin]

  def self.from_omniauth(auth)
    self.find_or_create_by(uid: auth[:uid], provider: auth[:provider]) do |u|
      u.first_name = auth[:info][:first_name]
      u.last_name = auth[:info][:last_name]
      u.email = auth[:info][:email]
      u.provider = auth[:provider]
      u.uid = auth[:uid]
      u.password = SecureRandom.hex(15)
    end
  end

end
