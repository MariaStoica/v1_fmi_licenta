class ComentariuTemasController < ApplicationController
  before_action :set_comentariu_tema, only: [:show, :edit, :update, :destroy]

  # GET /comentariu_temas
  # GET /comentariu_temas.json
  def index
    @comentariu_temas = ComentariuTema.all
  end

  # GET /comentariu_temas/1
  # GET /comentariu_temas/1.json
  def show
  end

  # GET /comentariu_temas/new
  def new
    @comentariu_tema = ComentariuTema.new
  end

  # GET /comentariu_temas/1/edit
  def edit
  end

  # POST /comentariu_temas
  # POST /comentariu_temas.json
  def create
    @comentariu_tema = ComentariuTema.new(comentariu_tema_params)

    respond_to do |format|
      if @comentariu_tema.save
        format.html { redirect_to @comentariu_tema, notice: 'Comentariu tema was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comentariu_tema }
      else
        format.html { render action: 'new' }
        format.json { render json: @comentariu_tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentariu_temas/1
  # PATCH/PUT /comentariu_temas/1.json
  def update
    respond_to do |format|
      if @comentariu_tema.update(comentariu_tema_params)
        format.html { redirect_to @comentariu_tema, notice: 'Comentariu tema was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comentariu_tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentariu_temas/1
  # DELETE /comentariu_temas/1.json
  def destroy
    @comentariu_tema.destroy
    respond_to do |format|
      format.html { redirect_to comentariu_temas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentariu_tema
      @comentariu_tema = ComentariuTema.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentariu_tema_params
      params.require(:comentariu_tema).permit(:user_id, :tema_id, :continut)
    end
end
