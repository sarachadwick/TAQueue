class MenusController < ApplicationController

  def home
    @users =  User.all
  end

end
