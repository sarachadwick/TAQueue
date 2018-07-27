module UsersHelper
  include SessionsHelper
  
  def active?
    return true unless current_user.active.nil? || !current_user.active
    return false
  end
end
