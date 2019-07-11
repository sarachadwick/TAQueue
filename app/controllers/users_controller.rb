class UsersController < ApplicationController
  def show
    @user = User.find(current_user.id)
  end

  def new
    @user = User.new
    @courses = Course.all
  end

  def create
    @user = User.new(user_params)
    @user.weekly_time = 0
    if @user.save
      log_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def start
    @user = User.find_by(id: params[:id])
    @user.update_attribute(:active, true)
    @user.update_attribute(:clocked_in_time, Time.current)
    if @user.weekly_time == nil || Time.current.wday == 1
      @user.update_attribute(:weekly_time, 0)
    end
  end

  def end
    @user = User.find_by(id: params[:id])
    @session_time = (Time.current - @user.clocked_in_time).to_i

    @user.update_attribute(:active, false)
    @user.update_attribute(:weekly_time, (@session_time + @user.weekly_time))
    @user.update_attribute(:clocked_in_time, :nil)
  end

  def dashboard
    @user = User.find_by(id: current_user.id)
    @semester = Semester.find_by(course_id: @user.course_id)
    @users = User.all
    
    if @user.weekly_hours.nil?
      @set_hours = false
    else
      @set_hours = true
      @hours_worked = { "Worked" => (@user.weekly_time/3600),
                        "Hours Left" => (@user.weekly_hours - (@user.weekly_time/3600)) }
    end

    if @semester.nil?
      @set_semester = false
    else
      @set_semester = true
      @help_averages = get_help_averages
    end
  end

  def edit
    @user = User.find_by(id: current_user.id)
    @user.update_attribute(:weekly_hours, params[:user][:weekly_hours])
    redirect_back(fallback_location: root_path)
  end

  def set_limit
    @user = User.find_by(id: current_user.id)
    @user.update_attribute(:limit, params[:new_limit])
    redirect_back(fallback_location: root_path)
  end

  private

  def get_help_averages
    help_averages = {}
    start_date = Semester.find_by(course_id: current_user.course_id).start_date
    semester_length = Semester.find_by(course_id: current_user.course_id).semester_length
    current_date = 0
    
    for week in 0..semester_length
      week_start = start_date + current_date.days
      week_end =  start_date + current_date.days + 7.day
      help_times = Student.where(["session_end >= ? and session_end < ? and course_id = ? and ta_id = ?",
                                  week_start, week_end, current_user.course_id, current_user.canvas_id])
      count = 0.0
      sum = 0.0
      
      for session in help_times do
        count += 1.0
        sum += ((session.session_end - session.helped_at)/60).to_d
        puts('-------------------')
        puts(count)
        puts('-------------------')
        puts(sum)
      end
      if count != 0
        help_averages[week] = sum/count
      else
        help_averages[week] = 0
      end

      current_date += 7
    end

    return help_averages
    #return {"1" => "2", "2" => "3"}
  end

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
