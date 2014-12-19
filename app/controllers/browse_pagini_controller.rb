class BrowsePaginiController < ApplicationController
  
  before_filter :login_required, except: :neutralPage#, :temeleMele, :studentiiMei, :alegerileMele]
  before_filter :checkIfProf, only: [:temeleMele, :studentiiMei]
  before_filter :checkIfStudent, only: :alegerileMele

  def neutralPage
    if get_current_user
      redirect_to browseHome_path
    end
  end


  def browseHome

    if get_current_user.rol == "Administrator"
      redirect_to controlPanel_path
    else

      @current_sesiune = Sesiune.where("data_end is null").first
      if @current_sesiune == nil
        @current_sesiune = Sesiune.where("data_end is not null").last
      end

      # dc studentul are deja licenta, nu mai are ce cauta pe pg de browse - este dus direct la licenta sa
      if get_current_user
        my_licentas = Licenta.where(user_id: get_current_user.id, sesiune_id: get_current_sesiune.id)
        if my_licentas
          my_licentas.each do |lic|
            if lic.renuntat != true
              redirect_to licentaHome_path
            end
          end  
        end
      end

      # @url_s = "http://fmi-api.herokuapp.com/students/" + session[:user_id]['uid'] + "?oauth_token=" + session[:user_id]['credentials']['token']
      # resp_s = Net::HTTP.get_response(URI.parse(@url_s))
      # @info_curent_s = JSON.parse(resp_s.body)

      # @url_t = "http://fmi-api.herokuapp.com/teachers/" + session[:user_id]['uid'] + "?oauth_token=" + session[:user_id]['credentials']['token']
      # resp_t = Net::HTTP.get_response(URI.parse(@url_t))
      # @info_curent_t = JSON.parse(resp_t.body)
        
      # @url = "http://fmi-api.herokuapp.com/teachers/13?oauth_token=" + session[:user_id]['credentials']['token']
      # resp = Net::HTTP.get_response(URI.parse(@url))
      # @info_curent = JSON.parse(resp.body)

      # cauta cuvintele din search in campurile temelor: nume si descriere
      if params[:search] and params[:search] != ""
        # sparg in cuv dupa virgule
        cuvinte = params[:search].split(/,/)
        @results = Tema.all
        # dc e student, ma uit doar in temele profilor de aceeasi specializare sau ambele specializari
        if get_current_user.rol == "Student"
          @results = @results.where(este_libera: true).where("user_id IN (SELECT id FROM users WHERE specializare LIKE 'Ambele' OR specializare LIKE ?)", "#{get_current_user.specializare}")
        end
        # iau fiecare cuvand din cuvinte si il bag pe rand in query
        cuvinte.each do |cuv|
          @results = @results.where("lower(temas.descriere) LIKE lower(?) or lower(temas.nume) LIKE lower(?)","%#{cuv}%","%#{cuv}%")
        end
        # http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-from
      end
        
      # profii care sunt eligibili pt licenta (si au aceeasi specializare ca studentul logat)
      if get_current_user and get_current_user.rol == "Student"
        @useri_profesori = User.profesori_eligibili.where("specializare LIKE ? OR 'Ambele'", "#{get_current_user.specializare}")
      else
        @useri_profesori = User.profesori_eligibili
      end

    end # end of if admin
        
  end # end of browseHomec


  def browseHomeArhiva
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
      # if get_current_user.rol == "Student"
        # @results = @results.where("user_id IN (SELECT id FROM users WHERE specializare LIKE 'Ambele' OR specializare LIKE ?)", "#{get_current_user.specializare}")
      # end
      cuvinte.each do |cuv|
        @results = @results.where("lower(temas.descriere) LIKE lower(?) or lower(temas.nume) LIKE lower(?)","%#{cuv}%","%#{cuv}%")
      end
      # http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-from
    end
      
    @useri_profesori = User.profesori_eligibili

    # # profii care sunt eligibili pt licenta
    # if get_current_user and get_current_user.rol == "Student"
    #   @useri_profesori = User.profesori_eligibili.where(specializare: get_current_user.specializare)
    # else
    #   @useri_profesori = User.profesori_eligibili
    # end
      
    # # dc studentul are deja licenta, nu mai are ce cauta pe pg de browse - este dus direct la licenta sa
    # if get_current_user
    #     if Licenta.where(user_id: get_current_user.id).first
    #         redirect_to licentaHome_path
    #     end
    # else
    #     # Daca Studentul nu e logat 
    #     redirect_to sessions_new_path    
    # end

  end # end of browseHomeArhiva


  def alegerileMele
    if params[:tema_id]
      if AlegeriUserTema.where(sesiune_id: get_current_sesiune.id).where(tema_id: params[:tema_id]).where(user_id: get_current_user.id).count == 0
        # @current_sesiune = Sesiune.where("data_end is null").first
        # if @current_sesiune == nil
        #   @current_sesiune = Sesiune.where("data_end is not null").last
        # end
        AlegeriUserTema.create(user_id: get_current_user.id, tema_id: params[:tema_id], status_profesor: "Pending", status_student: "Pending", sesiune_id: get_current_sesiune.id)
        flash[:notice] = "Alegere salvata cu succes"
      else
        flash[:notice] = "Alegerea selectata deja exista"
      end
    end

    temeLibereIds = Tema.where(sesiune_id: get_current_sesiune.id, este_libera: true).pluck(:id)
    @alegeri = AlegeriUserTema.where(sesiune_id: get_current_sesiune.id).where(user_id: get_current_user.id).where(tema_id: temeLibereIds)
  
  end # end of alegerileMele


  def temeleMele
    @current_sesiune = Sesiune.where("data_end is null").first
    if @current_sesiune == nil
      @current_sesiune = Sesiune.where("data_end is not null").last
    end

    # afiseaza toate domeniile profului curent, in view se afiseaza si toate temele domeniilor astora
    @domenii = Domeniu.where(user_id: get_current_user.id).where(sesiune_id: @current_sesiune.id)

  end # end of temeleMele


  def studentiiMei
    #toate domeniile din sesiunea curenta ale userului curent logat
    @domenii = Domeniu.where(sesiune_id: get_current_sesiune).where(user_id: get_current_user.id)
    
    @temeAleseDeStudenti = 0
    @domenii.each do |dom|
        dom.temas.each do |t|
            @temeAleseDeStudenti = @temeAleseDeStudenti + AlegeriUserTema.where(sesiune_id: get_current_sesiune).where(tema_id: t.id).count
        end
    end
    
    @nrStudentiCuLicenta = 0
    @domenii.each do |domeniu|
        domeniu.temas.each do |tema|
            Licenta.where(tema_id: tema.id, sesiune_id: get_current_sesiune.id, renuntat: false).each do |licenta|
                @nrStudentiCuLicenta = @nrStudentiCuLicenta + 1
            end
        end
    end

  end # end of studentiiMei


  def arhivaHome
    @sesiuni = Sesiune.all.order("data_start ASC")
  end


  def intreabaPage
    @comentarii = ComentariuTema.where(tema_id: params[:tema_id])
  end


  def adauga_comentariu
    ComentariuTema.create(continut: params[:comentariu], user_id: get_current_user.id, tema_id: params[:tema_id])
    redirect_to intreaba_path(tema_id: params[:tema_id])
  end


  def acceptaCaLicenta
      # dau mail profesorului ca acest student a acceptat tema sa.
      #UserMailer.notification_email(User.find(get_current_user.id).email,User.find(Domeniu.find(Tema.find(params[:temaaleasa_id]).domeniu_id).user_id).email, "Acceptare licenta", "Studentul cu numele " + User.find(get_current_user.id).nume + " " + User.find(get_current_user.id).prenume + "este acum studentul dumneavoastra pentru licenta" ).deliver
      
      # creez o intrare noua in licenta ca sa stiu ca acest student are aceasta tema la licenta si lucreaza la ea
      # renuntat == nil inseamna ca nu s-a renuntat la ea pana acum
      # renuntat == true inseamna ca a fost luata de cnv si acum e iar libera - a renuntat la ea
      # renuntat == false inseamna ca a fost renuntata si a luat-o inapoi proprietarul
      
      # caut tema asta 
      previousLicenta = Licenta.where(sesiune_id: get_current_sesiune.id).find_by_tema_id(params[:temaaleasa_id]) # nu ai nevoie de first pt ca e find si tema_id in model e sa fie unic
      licenta = previousLicenta

      # dc nu e - o iau eu pt prima data
      if previousLicenta == nil
        licenta = Licenta.create(user_id: get_current_user.id , tema_id: params[:temaaleasa_id], renuntat: false, sesiune_id: get_current_sesiune.id)
        # creez capitolele de inceput 
        Capitol.create(nume: "Introducere", licenta_id: licenta.id, numar: 1)
        Capitol.create(nume: "Concluzii", licenta_id: licenta.id, numar: 2)
        Capitol.create(nume: "Bibliografie", licenta_id: licenta.id, numar: 3)

      # dc e si are renuntat == true - inseamna ca a fost lasata de cineva (eu sau altul)
      elsif previousLicenta and previousLicenta.renuntat == true
        # dc sunt tot eu doar modific renuntat si nu mai creez alte capitole
        if previousLicenta.user_id == get_current_user.id
          previousLicenta.update_attributes(renuntat: false)
        # dc nu sunt eu tre sa sterg toata munca celui dinaintea mea si inregistrarea asta de licenta si sa fac alta
        else
          # sterg comentarii_licenta
          # if ComentariuLicenta.where(licenta_id: licenta.id).count > 0
          ComentariuLicenta.where(licenta_id: licenta.id).delete_all
          # end
          # sterg capitole
          Capitol.where(licenta_id: licenta.id).each do |cap|
            # sterg comentarii capitole
            ComentariuCapitol.where(capitol_id: cap.id).delete_all
            # sterf todos
            Todo.where(capitol_id: cap.id).delete_all
            # sterg fisiere
            Fisier.where(capitol_id: cap.id).each do |fis|
              # sterg comentarii_fisiere
              ComentariuFisier.where(fisier_id: fis.id).delete_all
              fis.destroy
            end
            cap.destroy
          end
          previousLicenta.destroy
          licenta = Licenta.create(user_id: get_current_user.id , tema_id: params[:temaaleasa_id], renuntat: false, sesiune_id: get_current_sesiune.id)
          # creez capitolele de inceput
          Capitol.create(nume: "Introducere", licenta_id: licenta.id, numar: 1)
          Capitol.create(nume: "Concluzii", licenta_id: licenta.id, numar: 2)
          Capitol.create(nume: "Bibliografie", licenta_id: licenta.id, numar: 3)
        end
      end

      # indiferent de situatie, scot tema asta din alegerile celorlalti studenti
      # ba nu - ca dc renunta la ea se va intoarce - las-o aici in alegeri ca dc e ocupata nu va fi afisata si dc se elibereaza va fi din nou acolo
      # AlegeriUserTema.where(sesiune_id: get_current_sesiune.id).where(tema_id: params[:temaaleasa_id]).each do |ales|
      #   ales.update_attributes(status_profesor: "Chosen by Another")
      # end
      
      # creez o intrare si in licenta_saved pt arhiva si in cazul in care studentul renunta si se intoarce mai tarziu la ea
      #LicentaSalvata.create(user_id: get_current_user.id , tema_id: params[:temaaleasa_id])
      
      # setez ca acceptat in alegeri - tema aleasa
      AlegeriUserTema.where(sesiune_id: get_current_sesiune.id).where(user_id: get_current_user.id, tema_id: params[:temaaleasa_id]).first.update_attributes(status_student: "Accepted")
      # setez restul ca rejected o data ce mi-am ales licenta
      alegeri = AlegeriUserTema.where(user_id: get_current_user.id, status_student: "Pending")
      alegeri.each do |alegere|
          alegere.update_attributes(status_student: "Rejected")
      end
      
      # tema aceasta nu mai este libera - deci nu mai apare in browse
      Tema.find(params[:temaaleasa_id]).update(este_libera: false)
      
      # du-ma la pagina de licenta
      redirect_to licentaHome_path
  end


  def sendmail
      #UserMailer.notification_email(User.find(get_current_user.id).email,params[:to], params[:title], params[:text]).deliver
      redirect_to licentaHome_path
  end


  def acceptStudenti
    get_current_user.update_attributes(are_domeniu_propuneri_studenti: true)

    # creez domeniul "Propuneri Studenti" dc nu exista deja
    if Domeniu.where(user_id: get_current_user.id).where(sesiune_id: get_current_sesiune.id).where(nume: "Propuneri Studenti").count == 0
      Domeniu.create(user_id: get_current_user.id, nume: "Propuneri Studenti", sesiune_id: get_current_sesiune.id, descriere: "Studentii pot propune teme de licenta numai sub acest domeniu, urmand ca apoi sa fie mutate in domeniul potrivit subiectului ales.")
    end

    redirect_to temeleMele_path
  end


  def refuzStudenti
    get_current_user.update_attributes(are_domeniu_propuneri_studenti: false)
    
    # dc exista domeniul "Propuneri Studenti" il redenumesc in "Neclasificate"
    domStudQuerry = Domeniu.where(user_id: get_current_user.id).where(sesiune_id: get_current_sesiune.id).where(nume: "Propuneri Studenti")
    if domStudQuerry.count == 1
      domStud = domStudQuerry.first
      domStud.update_attributes(nume: "Neclasificate", descriere: "")
    end

    redirect_to temeleMele_path
  end


end
