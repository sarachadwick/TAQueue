class MenusController < ApplicationController

  def home
    @users =  User.all
    @courses = Course.all
    @students = Student.where(session_end: nil)
  end

end
