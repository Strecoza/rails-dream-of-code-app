#Question 1
# find Intro to Programming courses
intro_class = CodingClass.find_by({ title: 'Intro to Programming' })
#find Spring 2025 course
spring_course = Course.find_by(coding_class_id: intro_class.id, trimester_id: 5)
#select enrollments and show 2 students id and email
spring_course.enrollments.first(2).each do |enrollment|
student = Student.find(enrollment.student_id)
puts "#{student.id}, #{student.email}"
end


#Question 2
# find Intro to Programming courses
intro_class = CodingClass.find_by({ title: 'Intro to Programming' })
#find right trimester
spring_trimester = Trimester.find_by(term: "Spring", year: "2025")
#find Spring 2025 course
spring_course = Course.find_by(coding_class_id: intro_class.id, trimester_id: spring_trimester.id)
#find ungraded students
ungraded_enrollments = spring_course.enrollments.where(final_grade: nil)
#choose 2 mentors
ungraded_enrollments.limit(2).each do |enrollment| 
    mentors_alert = MentorEnrollmentAssignment.find_by(enrollment_id: enrollment.id)
    next unless mentors_alert
    mentor  = Mentor.find_by(id: mentors_alert.mentor_id)
    puts "#{mentor.id}, #{mentor.email}" if mentor
end; nil