class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @courses = Course.all
  end

  def create
    @user = User.new(user_params)
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

  private

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
