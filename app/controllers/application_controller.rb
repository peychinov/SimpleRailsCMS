class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :load_root_categories

  def track_last_public_url
  	@last_public_url = request.url
  	@is_in_editor = false
  end

  private

	  # Overwriting the sign_out redirect path method
	  def after_sign_in_path_for(resource_or_scope)
	    "/admin/categories"
	  end

    def load_root_categories
      @root_categories = Category.where(:parent_id => nil)
    end
end
