class DomeniusController < ApplicationController
  before_filter :login_required
  before_action :set_domeniu, only: [:show, :edit, :update, :destroy]

  # GET /domenius
  # GET /domenius.json
  def index
  end

  # GET /domenius/1
  # GET /domenius/1.json
  def show
    @prof = User.find(@domeniu.user_id)
    @teme = Tema.where(sesiune_id: get_current_sesiune.id).where(domeniu_id: @domeniu.id).where(este_libera: true)
  end

  # GET /domenius/new
  def new
    @domeniu = Domeniu.new
    # @current_sesiune = Sesiune.where("data_end is null").first
    # if @current_sesiune == nil
    #   @current_sesiune = Sesiune.where("data_end is not null").last
    # end
  end

  # GET /domenius/1/edit
  def edit
    # @current_sesiune = Sesiune.where("data_end is null").first
    # if @current_sesiune == nil
    #   @current_sesiune = Sesiune.where("data_end is not null").last
    # end
  end

  # POST /domenius
  # POST /domenius.json
  def create
    @domeniu = Domeniu.new(domeniu_params)
    respond_to do |format|
      if @domeniu.save
        format.html { redirect_to temeleMele_path, notice: 'Domeniul a fost creat.' }
        format.json { render action: 'show', status: :created, location: @domeniu }
      else
        format.html { render action: 'new' }
        format.json { render json: @domeniu.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /domenius/1
  # PATCH/PUT /domenius/1.json
  def update
    respond_to do |format|
      if @domeniu.update(domeniu_params)
        format.html { redirect_to temeleMele_path, notice: 'Domeniul a fost modificat.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @domeniu.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /domenius/1
  # DELETE /domenius/1.json
  def destroy
    @domeniu.destroy
    respond_to do |format|
      format.html { redirect_to temeleMele_path }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_domeniu
    @domeniu = Domeniu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def domeniu_params
    params.require(:domeniu).permit(:nume, :descriere, :user_id, :sesiune_id)
  end
    
end
