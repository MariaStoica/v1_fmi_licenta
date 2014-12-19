class FisiersController < ApplicationController
  before_filter :check_if_owner_or_prof_of_owner, only: [:show, :edit, :update, :destroy, :download]
  before_filter :check_if_student_or_prof, only: [:index, :new, :create]

  before_action :set_fisier, only: [:show, :edit, :update, :destroy, :download]              
                   
  # GET /fisiers
  # GET /fisiers.json
  def index
    @fisiers = Fisier.all
    if params[:student_id] and params[:student_id] != ""
          @licenta = Licenta.where(user_id: params[:student_id]).where(renuntat: false).first
          @studentid = params[:student_id]
      else
          @licenta = Licenta.where(user_id: get_current_user.id).where(renuntat: false).first
      end
      @capitole = Capitol.where(licenta_id: @licenta.id).order(numar: :asc)
  end

  # GET /fisiers/1
  # GET /fisiers/1.json
  def show
    @comentarii = ComentariuFisier.where(fisier_id: @fisier.id)
    @capitol = Capitol.find(@fisier.capitol_id)
    @studentid = Licenta.find(@capitol.licenta_id).user_id
    @student = User.find(@studentid)
    @tema = Tema.find(Licenta.find(@capitol.licenta_id).tema_id)
  end

  # GET /fisiers/new
  def new
    @fisier = Fisier.new
    if get_current_user.rol == "Profesor"
        # domeniile profului
        @domenii = Domeniu.where(user_id: get_current_user.id)
        @domenii.each do |domeniu|
            domeniu.temas.each do |tema|
                @licente = Licenta.where(tema_id: tema.id)
            end
        end
    end
    
  end

  # GET /fisiers/1/edit
  def edit
  end

  # POST /fisiers
  # POST /fisiers.json
  def create
    @fisier = Fisier.new(fisier_params)
    # profesorii au voie sa adauge fisiere in bibliografie doar la licentele pe care le au in coordonare
    if (get_current_user.rol == "Profesor" and Capitol.find(@fisier.capitol_id).nume == "Bibliografie" and Domeniu.find(Tema.find(Licenta.find(Capitol.find(@fisier.capitol_id).licenta_id).tema_id).domeniu_id).user_id == get_current_user.id) or ( get_current_user.rol == "Student" and Licenta.find(Capitol.find(@fisier.capitol_id).licenta_id).user_id == get_current_user.id)
    respond_to do |format|
      if @fisier.save
          #@fisier.update_attributes(path: "public/data/" + @fisier.name)
          Fisier.save(@fisier,params[:fisier][:upload])
        format.html { redirect_to @fisier, notice: 'Fisier was successfully uploaded.' }
        format.json { render action: 'show', status: :created, location: @fisier }
      else
        format.html { render action: 'new' }
        format.json { render json: @fisier.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # GET /fisiers/1/download
  def download
	 send_file @fisier.path, :disposition => 'attachment'
   #redirect_to: licentaHome_path
  end

  # PATCH/PUT /fisiers/1
  # PATCH/PUT /fisiers/1.json
  def update
    respond_to do |format|
      if @fisier.update(fisier_params)
        format.html { redirect_to root_path, notice: 'Fisier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fisier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fisiers/1
  # DELETE /fisiers/1.json
  def destroy
    @fisier.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  def adauga_comentariu
	ComentariuFisier.create(continut: params[:continut], user_id: get_current_user.id, fisier_id: params[:fisier])
    #redirect_to licentaHome_path(:student_id => params[:student_id])
    redirect_to Fisier.find(params[:fisier])
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

  def check_if_student_or_prof
    if get_current_user
      if get_current_user.rol != "Student" and get_current_user.rol != "Profesor"
        redirect_to root_path
      end
    end
  end

  



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fisier
      @fisier = Fisier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fisier_params
        params.require(:fisier).permit(:name, :path, :capitol_id, :user_id)
    end

   
end
