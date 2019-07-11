class MenusController < ApplicationController

  def home
    @users = User.where(["course_id = ?", current_user.course_id])
    @courses = Course.all
    @students = Student.where(session_end: nil)
    @students = Student.where(["course_id = ? and session_end is ?", current_user.course_id, nil])
  end

end
