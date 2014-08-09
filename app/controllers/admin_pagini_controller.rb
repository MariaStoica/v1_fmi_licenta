class AdminPaginiController < ApplicationController
  def controlPanel
  	@u = current_user
  end

  def userSpecializari
  	@u = current_user
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


end
