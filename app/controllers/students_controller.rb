class StudentsController < ApplicationController
  def new
    @courses = Course.all
    @student = Student.new
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def help
    @student = Student.find_by(id: params[:student_id])
    @student.update_attribute(:being_helped, true)
    @student.update_attribute(:helped_by, params[:ta_name])
  end

  def end_session
    @student = Student.find_by(id: params[:student_id])
    @student.update_attribute(:being_helped, false)
    destroy
  end

  def destroy
    @student.delete
  end
  
    private
  
    def student_params
      params.require(:student).permit(:name, :reason, :course)
    end
end
