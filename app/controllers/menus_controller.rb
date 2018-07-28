class MenusController < ApplicationController

  def home
    @users =  User.all
    @courses = Course.all
    @students = Student.all
  end

end
