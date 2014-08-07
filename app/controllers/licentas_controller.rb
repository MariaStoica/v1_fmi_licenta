class LicentasController < ApplicationController
  before_action :set_licenta, only: [:show, :edit, :update, :destroy]

  # GET /licentas
  # GET /licentas.json
  def index
    @licentas = Licenta.all
  end

  # GET /licentas/1
  # GET /licentas/1.json
  def show
  end

  # GET /licentas/new
  def new
    @licenta = Licenta.new
  end

  # GET /licentas/1/edit
  def edit
  end

  # POST /licentas
  # POST /licentas.json
  def create
    @licenta = Licenta.new(licenta_params)

    respond_to do |format|
      if @licenta.save
        format.html { redirect_to @licenta, notice: 'Licenta was successfully created.' }
        format.json { render action: 'show', status: :created, location: @licenta }
      else
        format.html { render action: 'new' }
        format.json { render json: @licenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licentas/1
  # PATCH/PUT /licentas/1.json
  def update
    respond_to do |format|
      if @licenta.update(licenta_params)
        format.html { redirect_to @licenta, notice: 'Licenta was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @licenta.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licentas/1
  # DELETE /licentas/1.json
  def destroy
    @licenta.destroy
    respond_to do |format|
      format.html { redirect_to licentas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licenta
      @licenta = Licenta.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licenta_params
      params.require(:licenta).permit(:user_id, :tema_id)
    end
end
