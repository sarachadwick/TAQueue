class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  private

    def course_params
      params.require(:prefix, :course_code).permit(:name)
    end
end
