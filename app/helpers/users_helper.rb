module UsersHelper
  include SessionsHelper

  def active?
    return true unless current_user.active.nil? || !current_user.active
    return false
  end

  def hasActiveUser?
    if User.all.where(active: true).size > 0
      true
    else
      false
    end
  end
end
