class SemestersController < ApplicationController
  def new
    #@semester = Semester.new()
  end

  def create
    @semester = Semester.new(semester_params)
    @semester.course_id = current_user.course_id
    if @semester.save
      redirect_to users_dashboard_url
    end
  end

  private

  def semester_params
    params.require(:semester).permit(:semester_length,
                                     :start_date, :course_id)
  end
end
