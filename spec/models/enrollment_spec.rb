# spec/models/enrollment_spec.rb
require 'rails_helper'

RSpec.describe Enrollment, type: :model do

 let(:coding_class) { 
    CodingClass.create(title: 'Test Class')
  }
  let(:trimester) { 
    Trimester.create(
      year: '2025',
      term: 'Winter',
      start_date: '2025-01-01',
      end_date: '2025-04-30',
      application_deadline: '2024-12-15'
    )
  }
  let(:course) {
    Course.create(coding_class: coding_class,
                  trimester: trimester)
  }

  let(:student) {
    Student.create!(first_name: 'Ava', last_name: 'Lee', email: 'ava@etest.com')
  }

  let(:deadline) { trimester.application_deadline }

  describe '.is_past_application_deadline' do
    it 'exist for enrollment' do
      enrollment = Enrollment.create!(student: student, course: course)
      expect { enrollment.is_past_application_deadline }.not_to raise_error(NoMethodError)
    end  

    context 'when created_at is after the deadline day ' do
      it 'returns true' do
        after_deadline = deadline.next_day.beginning_of_day
        enrollment = Enrollment.create!(student: student, course: course, created_at: after_deadline)
        expect(enrollment.is_past_application_deadline).to eq(true)
      end
    end

    context 'when created_at is during the deadline day ' do
      it 'returns false' do
        during_deadline = deadline.end_of_day
        enrollment = Enrollment.create!(student: student, course: course, created_at: during_deadline)
        expect(enrollment.is_past_application_deadline).to eq(false)
      end
    end

     context 'when created_at is before the deadline day ' do
      it 'returns false' do
        before_deadline = deadline.prev_day.end_of_day
        enrollment = Enrollment.create!(student: student, course: course, created_at: before_deadline)
        expect(enrollment.is_past_application_deadline).to eq(false)
      end
    end
   
  end
end