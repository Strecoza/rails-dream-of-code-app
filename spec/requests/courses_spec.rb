require 'rails_helper'

RSpec.describe 'Courses', type: :request do
  describe 'GET /courses/:id' do
    it 'shows the course page with enrolled students for current courses' do
        current_trimester = Trimester.create!(
            term: 'Current',
            year: Date.current.year.to_s,
            start_date: Date.current - 1.day,
            end_date:   Date.current + 3.month,
            application_deadline: Date.current - 3.week
        )

        cc = CodingClass.create!(title: 'Intro to Ruby')
        course = Course.create!(trimester: current_trimester, coding_class: cc)

        student = Student.create!(first_name: 'Eva', last_name: 'First', email: 'eva@example.com')
        Enrollment.create!(student: student, course: course)

        get course_path(course)

        expect(response).to have_http_status(:ok)
        #course title
        expect(response.body).to include('Intro to Ruby')  
        #enrolled student
        expect(response.body).to include('Eva First')  

        expect(response.body).to include('New enrollment')
        expect(response.body).to include(new_enrollment_path(course_id: course.id))
    end
  end
end