#Question 1
CodingClass.find_each do |coding_class|
   Course.create!(
    coding_class_id: coding_class.id , 
    trimester_id: '8', 
    max_enrollment: '25')
 end

 #I accidentally created dublicate of Fall 26 trimester and delete it
    Trimester.find_by(id: 9)&.destroy

 #Question 2 
    Student.create!(first_name: "Val", last_name: "Kot", email:"valkot@yahoo.com")

 #Steps to find mentor with less than 2 enrollments
    #1. Added to mentor model:
        #has_many :mentor_enrollment_assignments
        #has_many :enrollments, through: :mentor_enrollment_assignments 
        Mentor.all.find{:enrollments.count <= 2 } 
    #2. Mentor.all.find{mentor.enrollments.count <= 2 }
    #3 added to enrollment model:      has_one :mentor, through: :mentor_enrollment_assignments
        Mentor.all.find do |mentor|
            mentor.enrollments.count <= 2 
        end
#Find and create variables for mentor, student, course:
student = Student.find_by(first_name: 'Val')
mentor = Mentor.find_by(id: '22')
course = Course.joins(:coding_class, :trimester).find_by(
  coding_classes: { title: 'Intro to Programming' },
  trimesters: { year: 2026, term: 'Spring' }
)

#Enroll the student to the course:
Enrollment.create!(student: student, course: course)
enrollment = Enrollment.last

#Assign that mentor to new student's enrollment
MentorEnrollmentAssignment.create!(mentor: mentor, enrollment: enrollment)

#Question 3: project
My project is an app that helps elementary school students sign up for after-school enrichment classes. Students allowed to take up to two free classes during the school year, and they can choose to take them either both in the fall, both in the spring, or one in each trimester.

There are five types of classes offered each trimester: Art, Dance, Scratch, Basketball, and Lego. Each class has a mentor assigned to lead it. Enrollments - up to 30.

The app has three types of users:
Admins, who manage the system, add students data, add class offerings, and assign mentors.
Mentors, who can view the list of students in their classes.
Students, who can log in and enroll themselves in the classes they are interested in.

#Question 4. Text-based ERD, indicating table names and column names:

 users:
    id: integer
    name: string
    email: string
    role: integer (admin, mentor, student)
    password_digest: string

student_profiles:
    id: integer
    user_id: integer
    grade: string
    year: string

mentor_profiles
    id: integer
    user_id: integer 

trimesters
    id: integer
    name: string ("Fall", "Spring")
    year: string ( "2025–2026" or "2025", "2026")
    start_date: date
    end_date: date

class_offerings
    id: integer
    name: string ("Scratch", "Art", "Dance", "Lego", "Football")
    trimester_id: string 
    mentor_id: integer 
    max_students: integer 

enrollments
    id: integer
    student_id: integer 
    class_offering_id: integer
 