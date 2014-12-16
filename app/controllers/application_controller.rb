class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def login_required
    if !get_current_user
      respond_to do |format|
        format.html  {
          # flash[:notice] = "You need to login"
          # redirect_to '/auth/autentificare'
          # cred ca nu ma delogheaza din aplicatia centrala de asta mi se tot intoarce logged in desi eu ii dau logout
        }
        format.json {
          render :json => { 'error' => 'Access Denied' }.to_json
        }
      end
    end
  end

  def get_current_user
      @current_user = nil
    if session[:user_id]
       @current_user ||= User.find_by_email(session[:user_id]['extra']['email'])
      end
      return @current_user
  end

  def get_current_sesiune
    @current_s = Sesiune.where(este_deschisa: true).first
    if @current_s == nil
      @current_s = Sesiune.where("data_end is not null").last
    end
    return @current_s
  end

end
