class Schedule < ApplicationRecord
  belongs_to :user
  belongs_to :project

  validates :user_id, presence: true
  validates :project_id, presence: true
  validates :start_date, presence: true
  validates_uniqueness_of :start_date, scope: :user_id, message: 'user has already been scheduled on that day'
  validates :end_date, presence: true
  validates_uniqueness_of :end_date, message: 'user already has been scheduled that day', scope: :user_id
  validate :start_date_is_not_in_past, :end_date_is_not_before_start_date

  def start_time_format
    self.start_date.strftime("%B %d, %Y")
  end

  def end_time_format
      self.end_date.strftime("%B %d, %Y")
  end

  def year
    self.start_date.strftime("%Y")
  end

  def month
    self.start_date.strftime('%m')
  end


  def date
    self.start_date.strftime('%d')
  end

  def full_name
    self.user.full_name
  end

  def project_name
    self.project.name
  end

  def week_number
    self.start_date.strftime('%U')
  end

  def start_date_day_number
    self.start_date.strftime('%u').to_i
  end

  def end_date_day_number
    self.end_date.strftime('%u').to_i
  end

  def day_range
   (self.start_date_day_number.to_i)..(self.end_date_day_number.to_i)
  end

  def self.new_construction
    self.joins(:project).where('construction_type = ?', 'New Construction')
  end

  def self.tenent
    self.joins(:project).where('construction_type = ?', 'Tenent')
  end

  def self.current_week_schedule
    self.select{|p| p.week_number == Date.today.strftime('%U')}
  end

  def self.next_week_schedule
    self.select{|p| p.week_number == (Date.today.strftime('%U').to_i + 1).to_s}
  end

  def self.exclude_past_weeks_schedule
    self.select{|p| p.week_number >= Date.today.strftime('%U')}
  end

  def self.uniq_by_project
    self.select(:project_id).distinct
  end



  #validators
  def start_date_is_not_in_past
      if start_date.present? && start_date < Date.today
          errors.add(:start_date, "can't be in the past")
      end
  end

  def end_date_is_not_before_start_date
      if start_date > end_date
          errors.add(:end_date, "can't be set before start date")
      end
  end
end
