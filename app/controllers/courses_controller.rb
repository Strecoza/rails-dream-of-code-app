class CoursesController < ApplicationController
  before_action :set_course, only: [ :show, :edit, :update, :destroy ]

  # GET /courses or /courses.json
  def index
    @courses = Course.all
  end

  # GET /courses/1 or /courses/1.json
  def show
    #@course = Course.includes(:trimester, :coding_class, enrollments: :student)
     # .find(params[:id])
  end

  # GET /courses/new
  def new
    @course = Course.new
    load_selects
  end

  # GET /courses/1/edit
  def edit
    load_selects
  end

  # POST /courses or /courses.json
  def create
    @course= Course.new(course_params)
    respond_to do |format|
      if @course.save
        # Redirect to the course page
        format.html { redirect_to @course, notice: "Course was successfully created." }
        format.json { render :show, status: :created, location: @course }
      else
        load_selects
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1 or /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: "Course was successfully updated." }
        format.json { render :show, status: :ok, location: @course }
      else
        load_selects
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1 or /courses/1.json
  def destroy
    @course.destroy!

    respond_to do |format|
      format.html { redirect_to courses_path, status: :see_other, notice: "Course was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      #@course = Course.find(params[:id])
      @course = Course.includes(:trimester, :coding_class, enrollments: :student).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def course_params
      params.require(:course).permit(:coding_class_id, :trimester_id, :max_enrollment )
    end

    def load_selects
      @coding_classes = CodingClass.order(:title)
      @trimesters = Trimester.order(:start_date)
    end
end
