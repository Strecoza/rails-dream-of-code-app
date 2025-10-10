class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :mentor
  belongs_to :enrollment

  validate :lesson_and_enrollment_belong_to_same_course

  private

  def lesson_and_enrollment_belong_to_same_course
    return if lesson.blank? || enrollment.blank?
    if lesson.course_id != enrollment.course_id
      errors.add(:base, "Lesson and enrollment must belong to the same course")
    end
  end
end
