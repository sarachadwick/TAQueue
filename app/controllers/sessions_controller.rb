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
    @user = User.find_by(params[:id])
    @user.update_attribute(:active, false)
    
    log_out
    redirect_to root_url
  end
end
