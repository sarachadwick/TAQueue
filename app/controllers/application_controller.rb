class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  after_action :allow_iframe

  include SessionsHelper
  include CoursesHelper

  def allow_iframe
    response.headers.except! 'X-Frame-Options'
  end
end
