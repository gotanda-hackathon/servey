class ApplicationController < ActionController::Base

  def current_user
    @current_user ||= Customer.find_by(id: session[:id])
  end
end
