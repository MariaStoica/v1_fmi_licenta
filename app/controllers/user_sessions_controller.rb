class UserSessionsController < ApplicationController
  before_filter :login_required, :only => [ :destroy ]

  respond_to :html

  # omniauth callback method
  def create
    omniauth = env['omniauth.auth']
    logger.debug "+++ #{omniauth}"

    email = omniauth['extra']['email']

    user = User.find_by_email(email)

    if not user
      # New user registration
      user = User.new(:email => email)
    end    
    
    user.prenume = omniauth['extra']['first_name']
    user.nume  = omniauth['extra']['last_name']
    user.token = omniauth['credentials']['token']
    
    if omniauth['extra']['student'] == "true"
      rol = "Student"
      user.rol  = rol
      # fac un get ca sa am mai multe info despre el
      url = "http://fmi-api.herokuapp.com/students/" + omniauth['uid'] + "?oauth_token=" + omniauth['credentials']['token']
      resp = Net::HTTP.get_response(URI.parse(url))
      info_curent = JSON.parse(resp.body)
      user.grupa = info_curent['group_year'].to_s + info_curent['group_series'].to_s + info_curent['group_number'].to_s
      user.specializare = info_curent['specialization']
      if (info_curent['group_year'] == 4 and info_curent['specialization'] == "Tehnologia Informatiei") or (info_curent['group_year'] == 3 and (info_curent['specialization'] == "Informatica" or info_curent['specialization'] == "Matematica"))
        user.este_eligibil_licenta = true
      else
        user.este_eligibil_licenta = false
      end
    elsif omniauth['extra']['teacher'] == "true"
      rol = "Profesor"
      user.rol  = rol
      # fac un get ca sa am mai multe info despre el
      url = "http://fmi-api.herokuapp.com/teachers/" + omniauth['uid'] + "?oauth_token=" + omniauth['credentials']['token']
      resp = Net::HTTP.get_response(URI.parse(url))
      info_curent = JSON.parse(resp.body)
      user.specializare = info_curent['department']
      grad = info_curent['title']
      if grad == nil 
        grad = "smth"
      end
      user.grad = grad
      if grad == "Asistent" or grad == "Preparator"
        user.este_eligibil_licenta = false
      else
        user.este_eligibil_licenta = true
      end
    elsif omniauth['extra']['admin'] == "true"
       rol = "Admin"
       user.rol  = rol
    end

    
    user.save

    #p omniauth

    # Currently storing all the info
    session[:user_id] = omniauth

    flash[:notice] = "Successfully logged in"
    redirect_to root_path
  end

  # Omniauth failure callback
  def failure
    flash[:notice] = params[:message]

  end

  # logout - Clear our rack session BUT essentially redirect to the provider
  # to clean up the Devise session from there too !
  def destroy
    reset_session
    
    flash[:notice] = 'You have successfully signed out!'
    redirect_to "#{CUSTOM_PROVIDER_URL}/users/sign_out?oauth_token=" + @current_user.token
  end
end