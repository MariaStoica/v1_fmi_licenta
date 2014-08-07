class ComentariuFisiersController < ApplicationController
  before_action :set_comentariu_fisier, only: [:show, :edit, :update, :destroy]

  # GET /comentariu_fisiers
  # GET /comentariu_fisiers.json
  def index
    @comentariu_fisiers = ComentariuFisier.all
  end

  # GET /comentariu_fisiers/1
  # GET /comentariu_fisiers/1.json
  def show
  end

  # GET /comentariu_fisiers/new
  def new
    @comentariu_fisier = ComentariuFisier.new
  end

  # GET /comentariu_fisiers/1/edit
  def edit
  end

  # POST /comentariu_fisiers
  # POST /comentariu_fisiers.json
  def create
    @comentariu_fisier = ComentariuFisier.new(comentariu_fisier_params)

    respond_to do |format|
      if @comentariu_fisier.save
        format.html { redirect_to @comentariu_fisier, notice: 'Comentariu fisier was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comentariu_fisier }
      else
        format.html { render action: 'new' }
        format.json { render json: @comentariu_fisier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentariu_fisiers/1
  # PATCH/PUT /comentariu_fisiers/1.json
  def update
    respond_to do |format|
      if @comentariu_fisier.update(comentariu_fisier_params)
        format.html { redirect_to @comentariu_fisier, notice: 'Comentariu fisier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comentariu_fisier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentariu_fisiers/1
  # DELETE /comentariu_fisiers/1.json
  def destroy
    @comentariu_fisier.destroy
    respond_to do |format|
      format.html { redirect_to comentariu_fisiers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentariu_fisier
      @comentariu_fisier = ComentariuFisier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentariu_fisier_params
      params.require(:comentariu_fisier).permit(:user_id, :fisier_id, :continut)
    end
end
