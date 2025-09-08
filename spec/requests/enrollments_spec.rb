require 'rails_helper'

RSpec.describe 'Enrollments', type: :request do
    describe 'GET /enrollments/new' do
        it 'render the form and shows the course if course_id provided ' do
            trimester = Trimester.create!(
                term: 'Current', year: Date.current.year.to_s,
                start_date: Date.current - 1.day, 
                end_date: Date.current + 3.month,
                application_deadline: Date.current - 3.week
            )
            cc     = CodingClass.create!(title: 'Intro to Ruby')
            course = Course.create!(trimester: trimester, coding_class: cc)

            get new_enrollment_path(course_id: course.id)

            expect(response).to have_http_status(:ok)
            expect(response.body).to include('New enrollment')
            expect(response.body).to include('Intro to Ruby')
        end
    end

    describe 'POST /enrollments' do
        it 'create an enrollment and redirects back to the course page' do
            trimester = Trimester.create!(
                term: 'Current', year: Date.current.year.to_s,
                start_date: Date.current - 1.day, 
                end_date: Date.current + 3.month,
                application_deadline: Date.current - 3.week
            )
            cc      = CodingClass.create!(title: 'Intro to Ruby')
            course  = Course.create!(trimester: trimester, coding_class: cc)
            student = Student.create!(first_name: 'Eva', last_name: 'First', email: 'eva@example.com')

            post enrollments_path, params: { enrollment: { course_id: course.id, student_id: student.id } }

            expect(response).to have_http_status(:found)
            follow_redirect!
            expect(response.body).to include('Intro to Ruby')
            expect(response.body).to include('Eva First')
        end
    end
end