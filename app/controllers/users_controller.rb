class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
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
  end

  def end
    @user = User.find_by(id: params[:id])
    @user.update_attribute(:active, false)
  end
  
  private
  
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
end
