module SessionsHelper
  def log_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def current_course
    @current_course ||= Course.find_by(course_id: current_user.course_id)
  end

  def is_ta?
    current_user.ta
  end

  def logged_in?
    puts(current_user)
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
