class AdminDashboardController < ApplicationController
  def index
    # Find current trimester
    @current_trimester = Trimester
      .where("start_date <= ? AND end_date >= ?", Date.current, Date.current)
      .first

    # Find closest upcoming trimester
    @upcoming_trimester = Trimester
      .where("start_date > ? AND start_date <=?", Date.current, Date.current+6.months)
      .order(:start_date)
      .first

    # show on dashboard
    @current_courses  = @current_trimester  ? @current_trimester.courses.includes(:coding_class)  : []
    @upcoming_courses = @upcoming_trimester ? @upcoming_trimester.courses.includes(:coding_class) : []
  end
end
