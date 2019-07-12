class StudentsController < ApplicationController
  def new
    # @student = Student.new
  end

  def create
    puts(student_params)
    @student = Student.new(student_params)
    if @student.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def help
    if User.find_by(id: params[:ta_id]).active == false
      return
    end
    @student = Student.find_by(id: params[:student_id])
    @student.update_attributes(:being_helped => true,
                               :helped_by => params[:ta_name],
                               :helped_at => Time.current,
                               :ta_id => current_user.canvas_id)
  end

  def end_session
    if User.find_by(id: params[:ta_id]).active == false
      return
    end
    @student = Student.find_by(id: params[:student_id])
    @student.update_attributes(:being_helped => false,
                               :session_end => Time.current)
  end

  def end_student_session
      @student = Student.find_by(student_id: params[:student_id])
      @student.update_attributes(:being_helped => false,
                                :session_end => Time.current)
      destroy
      redirect_to root_url
  end

  def destroy
    @student.delete
  end

    private

    def student_params
      params.require(:student).permit(:reason)
      {
        name: current_user.name,
        course: current_course,
        reason: params[:student][:reason],
        student_id: current_user.canvas_id,
        course_id: current_course.course_id
      }
    end

    def _new
      @current_user_session_id = current_user.canvas_id
    end
end
