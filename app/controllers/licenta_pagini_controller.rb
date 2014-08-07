class LicentaPaginiController < ApplicationController
    before_filter :check_if_owner_or_prof_of_owner
    
  def licentaHome
      # dc e prof tre sa dea prin parametru id-ul studentului
      if(params[:student_id])
          @licenta = Licenta.where(user_id: params[:student_id]).first
          @capitole = Licenta.where(user_id: params[:student_id]).first.capitols
          @comentarii = ComentariuLicenta.where(licenta_id: @licenta.id)
          @student_id = params[:student_id]
      # dc e studentul
      else
          @licenta = Licenta.where(user_id: current_user.id).first
          @capitole = Licenta.where(user_id: current_user.id).first.capitols
          @comentarii = ComentariuLicenta.where(licenta_id: @licenta.id)
      end
      
      @progres = 0
      
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
      ComentariuLicenta.create(continut: params[:comentariu], user_id: current_user.id, licenta_id: params[:licenta])
      # dc prof
      if(params[:student_id])
          redirect_to licentaHome_path(student_id: params[:student_id])
          else # dc stuedntul
          redirect_to licentaHome_path
      end
  end

  def capitolPage
  end

  def capitolEdit
  end

  def capitolNew
  end

  def fisierPage
  end

  def fisierNew
  end


  def todoEdit
  end
  
  def check_if_owner_or_prof_of_owner
      # dc prof - vezi sa fie cel coordonator (vezi in alegeri si statusuri)
      if(params[:student_id])
          licenta = Licenta.where(user_id: params[:student_id]).first
          temaid = AlegeriUserTema.where(user_id: params[:student_id]).first.tema_id
          tema = Tema.find(temaid)
          if current_user.id != Domeniu.find(tema.domeniu_id).user_id
              redirect_to(root_path, :notice =>"Nu ai voie aici.")
          end
      # dc student - vezi sa fie cel mentionat in licenta
      else
          licenta = Licenta.where(user_id: current_user.id).first
          if licenta.user_id != current_user.id
              redirect_to(root_path, :notice =>"Nu ai voie aici.")
          end
      end



  end
  
end
