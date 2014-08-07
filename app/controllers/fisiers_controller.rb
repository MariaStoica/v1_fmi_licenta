class FisiersController < ApplicationController
  before_action :set_fisier, only: [:show, :edit, :update, :destroy, :download]              
                   
  # GET /fisiers
  # GET /fisiers.json
  def index
    @fisiers = Fisier.all
    if(params[:student_id])
          @licenta = Licenta.where(user_id: params[:student_id]).first
      else
          @licenta = Licenta.where(user_id: current_user.id).first
      end
      @capitole = Capitol.where(licenta_id: @licenta.id)
  end

  # GET /fisiers/1
  # GET /fisiers/1.json
  def show
      @comentarii = ComentariuFisier.where(fisier_id: @fisier.id)
      @capitol = Capitol.find(@fisier.capitol_id)
      @studentid = Licenta.find(@capitol.licenta_id).user_id
  end

  # GET /fisiers/new
  def new
    @fisier = Fisier.new
    # proful n-are voie sa bage fisiere in alte capitole in afara de bibliografie
    # dc schimba parametrii de mana, o sa poata adauga numai in cap bibliografie al licentelor la care este prof coordonator - dc a iesit din raza o sa il trimit inapoi la root. oricum, nu e moral sa umblii cu parametrii de mana - asa ca macar nu se baga peste licenta unuia la care nu e prof coord - doar in licentele la care e si cap alea sa fie doar bibliografia.
    if current_user.rol == "Profesor"
        # domeniile profului
        @domenii = Domeniu.where(user_id: current_user.id)
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
	ComentariuFisier.create(continut: params[:continut], user_id: current_user.id, fisier_id: params[:fisier])
    #redirect_to licentaHome_path(:student_id => params[:student_id])
    redirect_to Fisier.find(params[:fisier])
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
