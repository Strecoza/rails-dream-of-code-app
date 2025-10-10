class Student < ApplicationRecord
  has_many :enrollments, dependent: :destroy
  has_many :courses, through: :enrollments
  has_many :submissions, through: :enrollments

  before_validation :downcase_email

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true

  #validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  def full_name
    "#{first_name} #{last_name}"
  end

   private

  def downcase_email
    self.email = email.to_s.downcase.strip
  end
end
