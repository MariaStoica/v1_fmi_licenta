class BrowsePaginiController < ApplicationController
  
  before_filter :login_required

  def browseHome
	  @u = current_user # dc nu pun asta nu recunoaste @current_user 

    # @url_s = "http://fmi-api.herokuapp.com/students/" + session[:user_id]['uid'] + "?oauth_token=" + session[:user_id]['credentials']['token']
    # resp_s = Net::HTTP.get_response(URI.parse(@url_s))
    # @info_curent_s = JSON.parse(resp_s.body)

    # @url_t = "http://fmi-api.herokuapp.com/teachers/" + session[:user_id]['uid'] + "?oauth_token=" + session[:user_id]['credentials']['token']
    # resp_t = Net::HTTP.get_response(URI.parse(@url_t))
    # @info_curent_t = JSON.parse(resp_t.body)
      
    # @url = "http://fmi-api.herokuapp.com/teachers/13?oauth_token=" + session[:user_id]['credentials']['token']
    # resp = Net::HTTP.get_response(URI.parse(@url))
    # @info_curent = JSON.parse(resp.body)

      # cauta cuvintele din search in teme: nume si descriere
      if params[:search] and params[:search] != ""
          # sparg in cuv dupa virgule
          cuvinte = params[:search].split(/,/)
          # iau fiecare cuvand din cuvinte si il bag pe rand in query
          @results = Tema.all
          if current_user.rol == "Student"
            @results = @results.where("user_id IN (SELECT id FROM users WHERE specializare LIKE 'Ambele' OR specializare LIKE ?)", "#{current_user.specializare}")
          end
          cuvinte.each do |cuv|
            @results = @results.where("lower(temas.descriere) LIKE lower(?) or lower(temas.nume) LIKE lower(?)","%#{cuv}%","%#{cuv}%")
          end
          # http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-from
      end
      
      # profii care sunt eligibili pt licenta
      if current_user and current_user.rol == "Student"
        @useri_profesori = User.profesori_eligibili.where(specializare: current_user.specializare)
      else
        @useri_profesori = User.profesori_eligibili
      end
        
      # dc studentul are deja licenta, nu mai are ce cauta pe pg de browse - este dus direct la licenta sa
      if current_user
          if Licenta.where(user_id: current_user.id).first
              redirect_to licentaHome_path
          end
      else
          # Daca Studentul nu e logat 
          redirect_to sessions_new_path    
      end
  end

  def browseHomeArhiva
    @u = current_user
    @selected_sesiune = Sesiune.find(params[:sesiune_id])
    # @current_sesiune = Sesiune.where("data_end is not null").first

    # tabelele care au sesiune_id sunt:
    # alegeri_user_temas - pt a stii ce lucrari s-au luat si de catre care studenti
    # licenta_salvatas
    # temas - pt a fi afisate in arhiva

    # cauta cuvintele din search in teme: nume si descriere
      if params[:search] and params[:search] != ""
          # sparg in cuv dupa virgule
          cuvinte = params[:search].split(/,/)
          # iau fiecare cuvand din cuvinte si il bag pe rand in query
          @results = Tema.all.where(sesiune_id: @selected_sesiune.id)
          if current_user.rol == "Student"
            @results = @results.where("user_id IN (SELECT id FROM users WHERE specializare LIKE 'Ambele' OR specializare LIKE ?)", "#{current_user.specializare}")
          end
          cuvinte.each do |cuv|
            @results = @results.where("lower(temas.descriere) LIKE lower(?) or lower(temas.nume) LIKE lower(?)","%#{cuv}%","%#{cuv}%")
          end
          # http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-from
      end
      
      # profii care sunt eligibili pt licenta
      if current_user and current_user.rol == "Student"
        @useri_profesori = User.profesori_eligibili.where(specializare: current_user.specializare)
      else
        @useri_profesori = User.profesori_eligibili
      end
        
      # dc studentul are deja licenta, nu mai are ce cauta pe pg de browse - este dus direct la licenta sa
      if current_user
          if Licenta.where(user_id: current_user.id).first
              redirect_to licentaHome_path
          end
      else
          # Daca Studentul nu e logat 
          redirect_to sessions_new_path    
      end

  end

  def alegerileMele
  	@u = current_user
    if params[:tema_id]
          if AlegeriUserTema.where(tema_id: params[:tema_id]).where(user_id: current_user.id).count == 0
              AlegeriUserTema.create(user_id: current_user.id, tema_id: params[:tema_id], status_profesor: "Pending", status_student: "Pending")
              flash[:notice] = "Alegere salvata cu succes"
              else
              flash[:notice] = "Alegerea selectata deja exista"
          end
      end
      @alegeri = AlegeriUserTema.where(user_id: current_user.id)
      @teme = Tema.all
  end

  def temeleMele
  	@u = current_user
    # afiseaza toate domeniile profului curent, in view se afiseaza si toate temele domeniilor astora
    @domenii = Domeniu.where(user_id: current_user.id)
  end

  def studentiiMei
  	@u = current_user
    @users = User.all
      @domenii = Domeniu.where(user_id: current_user.id)    #toate domeniile userului curent logat
      @alegeri = AlegeriUserTema.all
      @alese = 0
      
      @domenii.each do |dom|
          dom.temas.each do |t|
              @alese = @alese + @alegeri.where(tema_id: t.id).count
          end
      end
      
      @nrStudenti = 0
      @domenii.each do |domeniu|
          domeniu.temas.each do |tema|
              Licenta.where(tema_id: tema.id).each do |licenta|
                  @nrStudenti = @nrStudenti + 1
              end
          end
      end
  end

  def arhivaHome
    @u = current_user
    @sesiuni = Sesiune.all.order("data_start ASC")
  end

  def intreabaPage
  end



  def accepta
      # dau mail profesorului ca acest student a acceptat tema sa.
      #UserMailer.notification_email(User.find(current_user.id).email,User.find(Domeniu.find(Tema.find(params[:temaaleasa_id]).domeniu_id).user_id).email, "Acceptare licenta", "Studentul cu numele " + User.find(current_user.id).nume + " " + User.find(current_user.id).prenume + "este acum studentul dumneavoastra pentru licenta" ).deliver
      # creez o intrare noua in licenta ca sa stiu ca acest student are aceasta tema la licenta si lucreaza la ea
      licenta = Licenta.create(user_id: current_user.id , tema_id: params[:temaaleasa_id])
      # creez o intrare si in licenta_saved pt arhiva si in cazul in care studentul renunta si se intoarce mai tarziu la ea
      LicentaSalvata.create(user_id: current_user.id , tema_id: params[:temaaleasa_id])
      # creez capitolele de inceput
      Capitol.create(nume: "Introducere", licenta_id: licenta.id, numar: 1)
      Capitol.create(nume: "Concluzii", licenta_id: licenta.id, numar: 2)
      Capitol.create(nume: "Bibliografie", licenta_id: licenta.id, numar: 3)
      # setez ca acceptat in alegeri - tema aleasa
      AlegeriUserTema.where(user_id: current_user.id, tema_id: params[:temaaleasa_id]).first.update_attributes(status_student: "Accepted")
      # setez restul ca rejected o data ce mi-am ales licenta
      alegeri = AlegeriUserTema.where(user_id: current_user.id, status_student: "Pending")
      alegeri.each do |alegere|
          alegere.update_attributes(status_student: "Rejected")
      end
      # tema aceasta nu mai este libera - deci nu mai apare in browse
      Tema.find(params[:temaaleasa_id]).update(este_libera: false)
      # du-ma la pagina de licenta
      redirect_to licentaHome_path
  end

  def sendmail
      #UserMailer.notification_email(User.find(current_user.id).email,params[:to], params[:title], params[:text]).deliver
      redirect_to licentaHome_path
  end

end
