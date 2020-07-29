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
  has_one :helper
  has_many :users_badges
  has_many :badges, through: :users_badges

  #nested form association
  accepts_nested_attributes_for :foreman, allow_destroy: true
  accepts_nested_attributes_for :helper, allow_destroy: true

  #enum access control
  enum role: [:user, :admin, :super_admin]

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

  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def self.all_but_foreman
    self.left_outer_joins(:foreman).where(foremen: {id: nil})
  end

  def self.all_but_helper
    self.left_joins(:helper).where(helpers: {id: nil})
  end

  def self.foreman_all
    self.joins(:foreman)
  end

  def self.helper_all
    self.joins(:helper)
  end

  def self.order_by_name
    self.order(:first_name)
  end

end
