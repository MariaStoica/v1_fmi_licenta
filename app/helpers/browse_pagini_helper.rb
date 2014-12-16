module BrowsePaginiHelper

	def get_current_user
        @current_user = nil
    	if session[:user_id]
    	   @current_user ||= User.find_by_email(session[:user_id]['extra']['email'])
        end
        return @current_user
    end

	def has_domenii
        if Domeniu.where(user_id: current_user.id).count > 0
            return true
        end
        return false
    end

    def get_current_sesiune
        @current_s = Sesiune.where("data_end is null").first
        if @current_s == nil
          @current_s = Sesiune.where("data_end is not null").last
        end
        return @current_s
    end

end
