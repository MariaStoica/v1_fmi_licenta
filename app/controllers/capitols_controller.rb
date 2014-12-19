class CapitolsController < ApplicationController
  before_filter :check_if_owner_or_prof_of_owner, only: :show
  before_filter :check_if_student, only: [:new, :create]
  before_filter :check_if_owner ,only: [:edit, :update, :destroy]

  before_action :set_capitol, only: [:show, :edit, :update, :destroy]

  # GET /capitols
  # GET /capitols.json
  # def index
    # @capitols = Capitol.all
  # end

  # GET /capitols/1
  # GET /capitols/1.json
  def show
    @fisierele = Fisier.where(capitol_id: @capitol.id)
    @todouri = Todo.where(capitol_id: @capitol.id)
    @comentarii = ComentariuCapitol.where(capitol_id: @capitol.id)
    @studentid = Licenta.find(@capitol.licenta_id).user_id
    @student = User.find(@studentid)
    @tema = Tema.find(Licenta.find(@capitol.licenta_id).tema_id)
  end
  
  def adauga_comentariu
    ComentariuCapitol.create(continut: params[:comentariu], user_id: get_current_user.id, capitol_id: params[:capitol])
    redirect_to Capitol.find(params[:capitol])
  end

  # GET /capitols/new
  def new
      @capitol = Capitol.new
      licenta_id = Licenta.where(user_id: get_current_user.id)
      @capitole = Capitol.where(licenta_id: licenta_id)
  end

  # GET /capitols/1/edit
  def edit
  end

  # POST /capitols
  # POST /capitols.json
  def create
    @capitol = Capitol.new(capitol_params)

    if Licenta.find(@capitol.licenta_id).user_id == get_current_user.id
      respond_to do |format|
        if @capitol.save

          # actualizeaza numerele la restul capitolelor de dupa asta nou
          if Capitol.where("numar = ?", "#{@capitol.numar}").count > 1
            @capitole = Capitol.where("numar >= ? and id != ?", "#{@capitol.numar}", "#{@capitol.id}")
            @capitole.each do |cap|
              numar = cap.numar + 1
              cap.update_attributes(numar: numar)
            end
          end

          format.html { redirect_to root_path, notice: 'Capitol was successfully created.' }
          format.json { render action: 'show', status: :created, location: @capitol }
        else
          format.html { render action: 'new' }
          format.json { render json: @capitol.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end

  # PATCH/PUT /capitols/1
  # PATCH/PUT /capitols/1.json
  def update
    respond_to do |format|
      if @capitol.update(capitol_params)
        format.html { redirect_to root_path, notice: 'Capitol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @capitol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capitols/1
  # DELETE /capitols/1.json
  def destroy
    capitol_id = @capitol.id
    licenta_id = @capitol.licenta_id
    numar = @capitol.numar
    @capitol.destroy

    # actualizeaza numerele la restul capitolelor de dupa asta distrus
    @capitole = Capitol.where("licenta_id = ? and numar > ?", "#{licenta_id}", "#{numar}")
    if @capitole.count > 0
      @capitole.each do |cap|
        cap.update_attributes(numar: cap.numar-1)
      end
    end

    # sterge si todo-urile capitolului aluia din baza de date
    Todo.where(capitol_id: capitol_id).delete_all

    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  protected

  def check_if_owner_or_prof_of_owner
    @capitol = Capitol.find(params[:id])
    if get_current_user
      licenta_capitol_id = @capitol.licenta_id
      # licenta studentului logat trebuie sa fie aceeasi cu licenta capitolului pe care il acceseaza 
      if get_current_user.rol == "Student"
        licenta = Licenta.where(user_id: get_current_user.id, sesiune_id: get_current_sesiune.id).first
        if licenta
          if licenta.id != licenta_capitol_id
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      # id-ul profului logat trebuie sa fie acelasi cu id-ul posesorului domeniului temei din licenta de care apartine capitolul :))
      elsif get_current_user.rol == "Profesor"
        tema_id = Licenta.find(licenta_capitol_id).tema_id
        domeniu_id = Tema.find(tema_id).domeniu_id
        prof_id = Domeniu.find(domeniu_id).user_id
        if prof_id != get_current_user.id
          redirect_to root_path
        end
      else
        redirect_to root_path
      end # end of if rol
    else
      redirect_to root_path
    end # end of if current user
  end

  def check_if_student
    if get_current_user
      if get_current_user.rol != "Student"
        redirect_to root_path
      end
    end
  end

  def check_if_owner
    @capitol = Capitol.find(params[:id])
    if get_current_user
      licenta_capitol_id = @capitol.licenta_id
      # licenta studentului logat trebuie sa fie aceeasi cu licenta capitolului pe care il acceseaza 
      if get_current_user.rol == "Student"
        licenta = Licenta.where(user_id: get_current_user.id, sesiune_id: get_current_sesiune.id).first
        if licenta
          if licenta.id != licenta_capitol_id
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end # end of if rol
    else
      redirect_to root_path
    end # end of if current user
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capitol
      @capitol = Capitol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capitol_params
        params.require(:capitol).permit(:licenta_id, :nume, :numar)
    end
end
