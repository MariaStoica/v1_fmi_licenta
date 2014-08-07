class SesiunesController < ApplicationController
  before_action :set_sesiune, only: [:show, :edit, :update, :destroy]

  # GET /sesiunes
  # GET /sesiunes.json
  def index
    @sesiunes = Sesiune.all
  end

  # GET /sesiunes/1
  # GET /sesiunes/1.json
  def show
  end

  # GET /sesiunes/new
  def new
    @sesiune = Sesiune.new
  end

  # GET /sesiunes/1/edit
  def edit
  end

  # POST /sesiunes
  # POST /sesiunes.json
  def create
    @sesiune = Sesiune.new(sesiune_params)

    respond_to do |format|
      if @sesiune.save
        format.html { redirect_to @sesiune, notice: 'Sesiune was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sesiune }
      else
        format.html { render action: 'new' }
        format.json { render json: @sesiune.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sesiunes/1
  # PATCH/PUT /sesiunes/1.json
  def update
    respond_to do |format|
      if @sesiune.update(sesiune_params)
        format.html { redirect_to @sesiune, notice: 'Sesiune was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @sesiune.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sesiunes/1
  # DELETE /sesiunes/1.json
  def destroy
    @sesiune.destroy
    respond_to do |format|
      format.html { redirect_to sesiunes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sesiune
      @sesiune = Sesiune.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sesiune_params
      params.require(:sesiune).permit(:data_start, :data_end)
    end
end
