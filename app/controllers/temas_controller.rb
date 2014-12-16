class TemasController < ApplicationController
  before_action :set_tema, only: [:show, :edit, :update, :destroy]

  # GET /temas
  # GET /temas.json
  def index
    #@temas = Tema.all
    #@domenii = Domeniu.where(user_id: get_current_user.id)
  end
  
  # GET /temas/1
  # GET /temas/1.json
  def show
    @domeniu = Domeniu.find(@tema.domeniu_id)
    @prof = User.find(@domeniu.user_id)
  end

  # GET /temas/new
  def new
    @tema = Tema.new
    # @current_sesiune = Sesiune.where("data_end is null").first
    # if @current_sesiune == nil
    #   @current_sesiune = Sesiune.where("data_end is not null").last
    # end
  end

  # GET /temas/1/edit
  def edit
    # @current_sesiune = Sesiune.where("data_end is null").first
    # if @current_sesiune == nil
    #   @current_sesiune = Sesiune.where("data_end is not null").last
    # end
  end

  # POST /temas
  # POST /temas.json
  def create
    @tema = Tema.new(tema_params)

    respond_to do |format|
      if @tema.save

        # dc tema a fost creata de un student, sa o adaug la alererile sale
        if User.find(@tema.user_id).rol == "Student"
          # @current_sesiune = Sesiune.where("data_end is null").first
          # if @current_sesiune == nil
          #   @current_sesiune = Sesiune.where("data_end is not null").last
          # end
          AlegeriUserTema.create(tema_id: @tema.id, user_id: @tema.user_id, status_profesor: "Pending", status_student: "Pending", sesiune_id: get_current_sesiune.id)
        end

        if get_current_user and get_current_user.rol == "Student" # "/domenius/" + @tema.domeniu_id.to_s
          format.html { redirect_to alegerileMele_path, notice: 'Tema a fost creată.' }
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
      params.require(:tema).permit(:nume, :descriere, :domeniu_id, :este_libera, :user_id, :sesiune_id)
    end
end
