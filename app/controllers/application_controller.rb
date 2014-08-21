class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def login_required
    if !current_user
      respond_to do |format|
        format.html  {
          redirect_to '/auth/autentificare'
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def current_user
    return nil unless session[:user_id]
    @current_user ||= User.find_by_email(session[:user_id]['extra']['email'])
  end

  def get_current_sesiune
    @current_s = Sesiune.where("data_end is null").first
    if @current_s == nil
      @current_s = Sesiune.where("data_end is not null").last
    end
    return @current_s
  end

end
