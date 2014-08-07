class LicentaSalvatasController < ApplicationController
  before_action :set_licenta_salvata, only: [:show, :edit, :update, :destroy]

  # GET /licenta_salvatas
  # GET /licenta_salvatas.json
  def index
    @licenta_salvatas = LicentaSalvata.all
  end

  # GET /licenta_salvatas/1
  # GET /licenta_salvatas/1.json
  def show
  end

  # GET /licenta_salvatas/new
  def new
    @licenta_salvata = LicentaSalvata.new
  end

  # GET /licenta_salvatas/1/edit
  def edit
  end

  # POST /licenta_salvatas
  # POST /licenta_salvatas.json
  def create
    @licenta_salvata = LicentaSalvata.new(licenta_salvata_params)

    respond_to do |format|
      if @licenta_salvata.save
        format.html { redirect_to @licenta_salvata, notice: 'Licenta salvata was successfully created.' }
        format.json { render action: 'show', status: :created, location: @licenta_salvata }
      else
        format.html { render action: 'new' }
        format.json { render json: @licenta_salvata.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /licenta_salvatas/1
  # PATCH/PUT /licenta_salvatas/1.json
  def update
    respond_to do |format|
      if @licenta_salvata.update(licenta_salvata_params)
        format.html { redirect_to @licenta_salvata, notice: 'Licenta salvata was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @licenta_salvata.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /licenta_salvatas/1
  # DELETE /licenta_salvatas/1.json
  def destroy
    @licenta_salvata.destroy
    respond_to do |format|
      format.html { redirect_to licenta_salvatas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_licenta_salvata
      @licenta_salvata = LicentaSalvata.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def licenta_salvata_params
      params.require(:licenta_salvata).permit(:user_id, :tema_id, :sesiune_id)
    end
end
