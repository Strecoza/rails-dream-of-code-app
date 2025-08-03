class Enrollment < ApplicationRecord
  belongs_to :course
  belongs_to :student
  has_one :mentor, through: :mentor_enrollment_assignments
end
