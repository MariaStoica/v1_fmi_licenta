class AdminPaginiController < ApplicationController
  include AdminPaginiHelper

  before_filter :login_required

  def controlPanel
    set_nr_max_studenti_per_prof 25
    @azi = Date.today
    if params[:data_end] and params[:data_end] != ""
      stopSesiuneCurenta
    end
  end

  def userSpecializari
  	@results = User.all.order("users.rol")
      if params[:rol] == "Profesor"
          # dau profii intai dupa eligibilitate licenta si apoi dupa nume
          # nu ii dau dupa grad pt ca numele gradelor sunt sortate alfabetic nu dupa ierarhia sensului lor
          @results = User.where(rol: "Profesor").order("users.este_eligibil_licenta desc").order("users.nume")
          if params[:specializare]
            @results = @results.where(specializare: params[:specializare])
          end
      elsif params[:rol] == "Student"
            # dau studentii pe grupa pe nume
            @results = User.where(rol: "Student").order("users.grupa").order("users.nume")
            if params[:specializare]
            @results = @results.where(specializare: params[:specializare])
          end
      end

      # cauta cuvintele din search in teme: nume si descriere
      if params[:search] and params[:search] != ""
          # sparg in cuv dupa virgule
          cuvinte = params[:search].split(/,/)
          # iau fiecare cuvand din cuvinte si il bag pe rand in query
          cuvinte.each do |cuv|
            @results = @results.where("lower(users.nume) LIKE lower(?) or lower(users.prenume) LIKE lower(?) or lower(users.grupa) LIKE lower(?) or lower(users.grad) LIKE lower(?)","%#{cuv}%","%#{cuv}%","%#{cuv}%","%#{cuv}%")
          end
      end
  end

  def stopSesiuneCurenta
    if params[:data_end] and params[:data_end] != ""
      # copiaza tot ce e in licenta in licenta_salvata cu sesiunea curenta
      Licenta.all.each do |lic|
        # folosesc ex_licenta_id ca sa gasesc capitolele, totodurile si fisierele unei anumite licente ca in tabelele lor sunt memorate dupa id-ul licentei din tabelul Licenta
        LicentaSalvata.create(sesiune_id: get_current_sesiune.id, user_id: lic.user_id, tema_id: lic.tema_id, ex_licenta_id: lic.id)
      end

      # si apoi goleste licenta
      Licenta.delete_all

      # se golesc deadline-urile
      Deadline.delete_all

      # current_sesiune = Sesiune.where(este_deschisa: true).first
      get_current_sesiune.update_attributes(data_end: params[:data_end], este_deschisa: false)

      # hai inapoi
      redirect_to "/admin_pagini/controlPanel"
    end 
  end

  def startSesiune
  end

end
