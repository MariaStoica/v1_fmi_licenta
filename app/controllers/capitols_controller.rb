class CapitolsController < ApplicationController
  before_action :set_capitol, only: [:show, :edit, :update, :destroy]

  # GET /capitols
  # GET /capitols.json
  def index
    @capitols = Capitol.all
  end

  # GET /capitols/1
  # GET /capitols/1.json
  def show
  end

  # GET /capitols/new
  def new
    @capitol = Capitol.new
  end

  # GET /capitols/1/edit
  def edit
  end

  # POST /capitols
  # POST /capitols.json
  def create
    @capitol = Capitol.new(capitol_params)

    respond_to do |format|
      if @capitol.save
        format.html { redirect_to @capitol, notice: 'Capitol was successfully created.' }
        format.json { render action: 'show', status: :created, location: @capitol }
      else
        format.html { render action: 'new' }
        format.json { render json: @capitol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /capitols/1
  # PATCH/PUT /capitols/1.json
  def update
    respond_to do |format|
      if @capitol.update(capitol_params)
        format.html { redirect_to @capitol, notice: 'Capitol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @capitol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /capitols/1
  # DELETE /capitols/1.json
  def destroy
    @capitol.destroy
    respond_to do |format|
      format.html { redirect_to capitols_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_capitol
      @capitol = Capitol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def capitol_params
      params.require(:capitol).permit(:licenta_id, :nume, :numar)
    end
end
