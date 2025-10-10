class TrimestersController < ApplicationController

  before_action :set_trimester, only: [:show, :edit, :update, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

   def index
    @trimesters = Trimester.order(:start_date)
  end

  def show  
  end

  def new
    @trimester = Trimester.new
  end

  def edit
  end

  def create
    @trimester = Trimester.new(trimester_params)
    if @trimester.save
      redirect_to @trimester, notice: "Trimester was created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    dl_param = params.dig(:trimester, :application_deadline)
    return head :bad_request if dl_param.blank?
    begin
      Date.parse(dl_param.to_s)
    rescue ArgumentError
      return head :bad_request
    end

    if @trimester.update(trimester_params)
      respond_to do |format|
        format.html { redirect_to @trimester, notice: "Trimester updated." }
        format.json { head :ok }
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @trimester.errors, status: :unprocessable_entity }
      end
    end
  end

 def destroy
    @trimester.destroy!
    redirect_to trimesters_path, status: :see_other, notice: "Trimester was successfully destroyed."
  end

  private
  def trimester_params
    params.require(:trimester).permit(:term, :year, :start_date, :end_date, :application_deadline)
  end

  def render_not_found
    head :not_found
  end
  
  def set_trimester
    @trimester = Trimester.find(params[:id])
  end
end