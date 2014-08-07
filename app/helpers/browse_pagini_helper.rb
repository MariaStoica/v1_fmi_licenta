module BrowsePaginiHelper

	def current_user
    	return nil unless session[:user_id]
    	@current_user ||= User.find_by_email(session[:user_id]['extra']['email'])
  	end

	def has_domenii
        if Domeniu.where(user_id: current_user.id).count > 0
            return true
        end
        return false
    end

end
