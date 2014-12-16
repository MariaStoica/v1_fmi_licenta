class LicentaPaginiController < ApplicationController
  before_filter :check_if_owner_or_prof_of_owner
    
  def licentaHome
    # dc e prof tre sa dea prin parametru id-ul studentului
    if(params[:student_id])
      @licenta = Licenta.where(user_id: params[:student_id]).where(renuntat: false).first
      @capitole = @licenta.capitols
      @comentarii = ComentariuLicenta.where(licenta_id: @licenta.id)
      @student_id = params[:student_id]
    # dc e studentul
    else
      @licenta = Licenta.where(user_id: get_current_user.id).where(renuntat: false).first
      @capitole = @licenta.capitols
      @comentarii = ComentariuLicenta.where(licenta_id: @licenta.id)
    end
    
    @progres = 0
    
    if params[:capitol_id] and params[:numar_nou] and params[:numar_victima] and params[:capitol_victima_id] and params[:capitol_id] != "" and params[:numar_nou] != "" and params[:numar_victima] != "" and params[:capitol_victima_id] != ""
      Capitol.find(params[:capitol_id]).update_attributes(numar: params[:numar_nou])
      Capitol.find(params[:capitol_victima_id]).update_attributes(numar: params[:numar_victima])
    end

    # cate todo gata / nr de todos
    # toate todourile din licenta asta
    @todos = Todo.find_by_sql("select * from todos where capitol_id in (select id from capitols where licenta_id=" + @licenta.id.to_s + ")")
    @gata = @todos.select{|t| t.este_gata == true}
    @nugata = @todos.select{|t| t.este_gata == false}
    if @todos.count == 0
      @progres = 0
    else
      @progres = (@gata.count * 100) / @todos.count
    end
  end
  
  def adauga_comentariu
    ComentariuLicenta.create(continut: params[:comentariu], user_id: get_current_user.id, licenta_id: params[:licenta])
    # dc prof
    if(params[:student_id])
      redirect_to licentaHome_path(student_id: params[:student_id])
      else # dc stuedntul
      redirect_to licentaHome_path
    end
  end

  def renuntaLaLicenta
    # gasesc licenta mea - a studentului - ca doar eu pot sa renunt la ea - nu va fi logat un prof sau admin sau secretariat
    puts "!!!! current user id = " + get_current_user.id.to_s
    @licenta = Licenta.where(user_id: get_current_user.id, renuntat: false).first
    puts "!!!! licenta = " + @licenta.id.to_s
    # if licentas
    #   licentas.each do |lic|
    #     if lic.renuntat != true
    #       @licenta = lic
    #     end
    #   end
    # end
    # ramane in bd cum ca a apartinut mie si acum i-am dat drumul - in caz ca vreau sa ma intorc la ea
    @licenta.update_attributes(renuntat: true)
    # eliberez tema
    Tema.find(@licenta.tema_id).update_attributes(este_libera: true)
    # hai sa imi aleg alta tema
    redirect_to root_path
  end

  def submitLicentaFinala
    # create capitolul de Licenta Finala daca nu exista deja
    if Capitol.where(licenta_id: params[:licenta_id]).where(este_licenta_finala: true).count == 0
      numar = Capitol.where(licenta_id: params[:licenta_id]).count + 1
      capitol = Capitol.create(nume: "Licenta finala", licenta_id: params[:licenta_id], este_licenta_finala: true, numar: numar)
    else
      capitol = Capitol.where(licenta_id: params[:licenta_id]).where(este_licenta_finala: true).first
    end
    redirect_to new_fisier_path(capitol_id: capitol.id)
  end


  protected
  
  def check_if_owner_or_prof_of_owner
    # dc prof - vezi sa fie cel coordonator (vezi in alegeri si statusuri)
    if(params[:student_id])
        licenta = Licenta.where(user_id: params[:student_id]).first
        temaid = AlegeriUserTema.where(user_id: params[:student_id]).first.tema_id
        tema = Tema.find(temaid)
        if get_current_user.id != Domeniu.find(tema.domeniu_id).user_id
            redirect_to(root_path, :notice =>"Nu ai voie aici.")
        end
    # dc student - vezi sa fie cel mentionat in licenta
    else
        licenta = Licenta.where(user_id: get_current_user.id).first
        if licenta.user_id != get_current_user.id
            redirect_to(root_path, :notice =>"Nu ai voie aici.")
        end
    end
  end
  
end
