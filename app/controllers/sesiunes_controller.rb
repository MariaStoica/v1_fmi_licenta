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
  # def edit
  # end

  # POST /sesiunes
  # POST /sesiunes.json
  def create
    @sesiune = Sesiune.new(sesiune_params)

    respond_to do |format|
      if @sesiune.save

        # duplic temele si domeniile din ultima sesiune
        @ultima_sesiune = Sesiune.where.not(data_end: nil).last
        Domeniu.where(sesiune_id: @ultima_sesiune.id).each do |dom|
          nou_dom = Domeniu.create(nume: dom.nume, descriere: dom.descriere, user_id: dom.user_id, sesiune_id: @sesiune.id)
          Tema.where(sesiune_id: @ultima_sesiune.id).where(domeniu_id: dom.id).each do |tema|
            Tema.create(nume: tema.nume, descriere: tema.descriere, domeniu_id: nou_dom.id, este_libera: tema.este_libera, user_id: tema.user_id, sesiune_id: @sesiune.id)
          end
        end

        # sterg tabelul Licenta
        Licenta.all.delete_all

        format.html { redirect_to controlPanel_path, notice: 'Sesiune was successfully created.' }
        format.json { render action: 'show', status: :created, location: @sesiune }
      else
        format.html { render action: 'new' }
        format.json { render json: controlPanel_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sesiunes/1
  # PATCH/PUT /sesiunes/1.json
  def update
    respond_to do |format|
      if @sesiune.update(sesiune_params)
        format.html { redirect_to controlPanel_path, notice: 'Sesiune was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: controlPanel_path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sesiunes/1
  # DELETE /sesiunes/1.json
  # def destroy
    # @sesiune.destroy
    # respond_to do |format|
      # format.html { redirect_to sesiunes_url }
      # format.json { head :no_content }
    # end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sesiune
      @sesiune = Sesiune.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sesiune_params
      params.require(:sesiune).permit(:data_start, :data_end, :deadline)
    end
    
end
