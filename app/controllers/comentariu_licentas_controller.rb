class ComentariuLicentasController < ApplicationController
  before_action :set_comentariu_licenta, only: [:show, :edit, :update, :destroy]

  # GET /comentariu_licentas
  # GET /comentariu_licentas.json
  def index
    @comentariu_licentas = ComentariuLicenta.all
  end

  # GET /comentariu_licentas/1
  # GET /comentariu_licentas/1.json
  def show
  end

  # GET /comentariu_licentas/new
  def new
    @comentariu_licenta = ComentariuLicenta.new
  end

  # GET /comentariu_licentas/1/edit
  def edit
  end

  # POST /comentariu_licentas
  # POST /comentariu_licentas.json
  def create
    @comentariu_licenta = ComentariuLicenta.new(comentariu_licenta_params)

    respond_to do |format|
      if @comentariu_licenta.save
        format.html { redirect_to @comentariu_licenta, notice: 'Comentariu licenta was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comentariu_licenta }
      else
        format.html { render action: 'new' }
        format.json { render json: @comentariu_licenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentariu_licentas/1
  # PATCH/PUT /comentariu_licentas/1.json
  def update
    respond_to do |format|
      if @comentariu_licenta.update(comentariu_licenta_params)
        format.html { redirect_to @comentariu_licenta, notice: 'Comentariu licenta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comentariu_licenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentariu_licentas/1
  # DELETE /comentariu_licentas/1.json
  def destroy
    @comentariu_licenta.destroy
    respond_to do |format|
      format.html { redirect_to comentariu_licentas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentariu_licenta
      @comentariu_licenta = ComentariuLicenta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentariu_licenta_params
      params.require(:comentariu_licenta).permit(:user_id, :licenta_id, :continut)
    end
end
