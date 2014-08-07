class FisiersController < ApplicationController
  before_action :set_fisier, only: [:show, :edit, :update, :destroy]

  # GET /fisiers
  # GET /fisiers.json
  def index
    @fisiers = Fisier.all
  end

  # GET /fisiers/1
  # GET /fisiers/1.json
  def show
  end

  # GET /fisiers/new
  def new
    @fisier = Fisier.new
  end

  # GET /fisiers/1/edit
  def edit
  end

  # POST /fisiers
  # POST /fisiers.json
  def create
    @fisier = Fisier.new(fisier_params)

    respond_to do |format|
      if @fisier.save
        format.html { redirect_to @fisier, notice: 'Fisier was successfully created.' }
        format.json { render action: 'show', status: :created, location: @fisier }
      else
        format.html { render action: 'new' }
        format.json { render json: @fisier.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /fisiers/1
  # PATCH/PUT /fisiers/1.json
  def update
    respond_to do |format|
      if @fisier.update(fisier_params)
        format.html { redirect_to @fisier, notice: 'Fisier was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @fisier.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /fisiers/1
  # DELETE /fisiers/1.json
  def destroy
    @fisier.destroy
    respond_to do |format|
      format.html { redirect_to fisiers_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_fisier
      @fisier = Fisier.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def fisier_params
      params.require(:fisier).permit(:name, :path, :adaugat, :user_id, :capitol_id)
    end
end
