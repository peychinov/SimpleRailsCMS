class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def track_last_public_url
  	@last_public_url = request.url
  	@is_in_editor = false
  end

  def track_last_admin_url
  	@last_admin_url = request.url
  	@is_in_editor = true
  end
end
