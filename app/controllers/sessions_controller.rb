class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    # If a TA signs out w/o ending their hours, do it for 'em
    @user = User.find_by(id: params[:id])
    if @user.active
      @session_time = (Time.current - @user.clocked_in_time).to_i

      @user.update_attribute(:weekly_time, (@session_time + @user.weekly_time))
      @user.update_attribute(:clocked_in_time, :nil)
    end
    @user.update_attribute(:active, false)

    log_out
    redirect_to root_url
  end
end
