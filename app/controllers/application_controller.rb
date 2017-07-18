class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # redirects to users_show_url on login
  def after_sign_in_path_for(resource_or_scope)
   current_user
  end

  # redirects to root_url on logout
  def after_sign_out_path_for(resource_or_scope)
    root_url
  end

end
