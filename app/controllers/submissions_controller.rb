class SubmissionsController < ApplicationController
  #GET / courses/:course_id/submissions/new
  def new
    @course = Course.includes(:lessons, enrollments: :student).find(params[:course_id])
    @submission = Submission.new
    @enrollments = @course.enrollments.includes(:student).order('students.last_name, students.first_name') 
  
    @lessons = @course.lessons.order(:id) 
    @mentors = Mentor.order(:last_name, :first_name)
  end

  #POST /courses/:course_id/submissions
  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
      @enrollments =@course.enrollments.includes(:student).order('students.last_name, students.first_name')
      @lessons =@course.lessons.order(:id) 
      @mentors =Mentor.order(:last_name, :first_name)
      render :new, status: :unprocessable_entity
    end
  end

  # GET /submissions/1/edit
  def edit
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
  end

  private
    # Only allow a list of trusted parameters through.
    def submission_params
      params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at)
    end
end
