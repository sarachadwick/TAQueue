class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    @course = Course.new(user_params)
    if @course.save
      redirect_to '/'
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:prefix, :course_code).permit(:name)
    end
end
