class Admin::AdminController < ApplicationController
	layout "admin"
	
	before_filter :authenticate_admin!, 
								:track_last_admin_url, :set_is_in_editor

  def track_last_admin_url
  	session["last_admin_url"] = request.url
  end

  def set_is_in_editor
  	@is_in_editor = true
  end

end