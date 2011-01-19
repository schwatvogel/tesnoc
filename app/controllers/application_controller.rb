# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include SessionsHelper
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_locale

  def set_locale
	  I18n.locale=params[:locale]
  end

  def default_url_options(options={})
	  logger.debug "default_url_options is passed options: #{options.inspect}\n"
	  { :locale=>I18n.locale }
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
