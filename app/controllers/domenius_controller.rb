class DomeniusController < ApplicationController
  before_action :set_domeniu, only: [:show, :edit, :update, :destroy]

  # GET /domenius
  # GET /domenius.json
  def index
    @u = current_user
    @domenius = Domeniu.all
    @useri = User.all
  end

  # GET /domenius/1
  # GET /domenius/1.json
  def show
      @u = current_user
      @prof = User.find(@domeniu.user_id)
      @teme = Tema.where(domeniu_id: @domeniu.id).where(este_libera: true)
  end

  # GET /domenius/new
  def new
    @u = current_user
    @domeniu = Domeniu.new
    @current_sesiune = Sesiune.where("data_end is null").first
    if @current_sesiune == nil
      @current_sesiune = Sesiune.where("data_end is not null").last
    end

  end

  # GET /domenius/1/edit
  def edit
    @current_sesiune = Sesiune.where("data_end is null").first
    if @current_sesiune == nil
      @current_sesiune = Sesiune.where("data_end is not null").last
    end
  end

  # POST /domenius
  # POST /domenius.json
  def create
    @u = current_user
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
    @u = current_user
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
    @u = current_user
    @domeniu.destroy
    respond_to do |format|
      format.html { redirect_to temeleMele_path }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_domeniu
      @u = current_user
      @domeniu = Domeniu.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def domeniu_params
      params.require(:domeniu).permit(:nume, :descriere, :user_id, :sesiune_id)
    end
    
    
    #def search
    #    @domenii_cautate = Domeniu.search params[:search]
    #end
    
    
    
    
    
end
