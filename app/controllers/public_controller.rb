class PublicController < ApplicationController
	before_filter :track_last_public_url, :set_is_in_editor

  def track_last_public_url
  	session["last_public_url"] = request.url
  end

  def set_is_in_editor
  	@is_in_editor = false
  end

end