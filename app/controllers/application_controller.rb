class ApplicationController < ActionController::Base
	before_action :check_if_blocked

	def check_if_blocked
	  if current_user && current_user.blocked?
	    sign_out current_user
	    redirect_to new_user_session_path, alert: "Your account has been blocked. Contact Admin."
	  end
	end

end
