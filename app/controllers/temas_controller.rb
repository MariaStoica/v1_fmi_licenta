class TemasController < ApplicationController
  before_action :set_tema, only: [:show, :edit, :update, :destroy]

  # GET /temas
  # GET /temas.json
  def index
      #@temas = Tema.all
      #@domenii = Domeniu.where(user_id: current_user.id)
  end
  
  # GET /temas/1
  # GET /temas/1.json
  def show
      # cand alege tema sa faca insert in tabelul alegeri
      #AlegeriUserTema.create(user_id: current_user.id, tema_id: @tema.id, status_profesor: "Pending", status_student: "Pending")
      @domeniu = Domeniu.find(@tema.domeniu_id)
      @prof = User.find(@domeniu.user_id)
      @u = current_user
  end

  # GET /temas/new
  def new
    @tema = Tema.new
  end

  # GET /temas/1/edit
  def edit
  end

  # POST /temas
  # POST /temas.json
  def create
    @tema = Tema.new(tema_params)

    respond_to do |format|
      if @tema.save
        if current_user and current_user.rol == "Student"
          format.html { redirect_to "/domenius/" + @tema.domeniu_id.to_s, notice: 'Tema a fost creată.' }
          format.json { render action: 'show', status: :created, location: @tema }
        else
          format.html { redirect_to temeleMele_path, notice: 'Tema a fost creată.' }
          format.json { render action: 'show', status: :created, location: @tema }
        end
      else
        format.html { render action: 'new' }
        format.json { render json: temeleMele_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temas/1
  # PATCH/PUT /temas/1.json
  def update
    respond_to do |format|
      if @tema.update(tema_params)
        format.html { redirect_to temeleMele_path, notice: 'Tema a fost modificată.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /temas/1
  # DELETE /temas/1.json
  def destroy
    @tema.destroy
    respond_to do |format|
      format.html { redirect_to temeleMele_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema
      @tema = Tema.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tema_params
      params.require(:tema).permit(:nume, :descriere, :domeniu_id, :este_libera, :user_id)
    end
end
