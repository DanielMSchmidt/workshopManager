class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :set_google_analytics

  def after_sign_in_path_for(resource)
    events_path
  end

  def set_google_analytics
    @ga = ENV["GOOGLE_ANALYTICS_TRACKING_CODE"]
  end
end
