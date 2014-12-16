class ComentariuCapitolsController < ApplicationController
  before_filter :login_required
  before_action :set_comentariu_capitol, only: [:show, :edit, :update, :destroy]

  # GET /comentariu_capitols
  # GET /comentariu_capitols.json
  def index
    @comentariu_capitols = ComentariuCapitol.all
  end

  # GET /comentariu_capitols/1
  # GET /comentariu_capitols/1.json
  def show
  end

  # GET /comentariu_capitols/new
  def new
    @comentariu_capitol = ComentariuCapitol.new
  end

  # GET /comentariu_capitols/1/edit
  def edit
  end

  # POST /comentariu_capitols
  # POST /comentariu_capitols.json
  def create
    @comentariu_capitol = ComentariuCapitol.new(comentariu_capitol_params)

    respond_to do |format|
      if @comentariu_capitol.save
        format.html { redirect_to @comentariu_capitol, notice: 'Comentariu capitol was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comentariu_capitol }
      else
        format.html { render action: 'new' }
        format.json { render json: @comentariu_capitol.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comentariu_capitols/1
  # PATCH/PUT /comentariu_capitols/1.json
  def update
    respond_to do |format|
      if @comentariu_capitol.update(comentariu_capitol_params)
        format.html { redirect_to @comentariu_capitol, notice: 'Comentariu capitol was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comentariu_capitol.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comentariu_capitols/1
  # DELETE /comentariu_capitols/1.json
  def destroy
    @comentariu_capitol.destroy
    respond_to do |format|
      format.html { redirect_to comentariu_capitols_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comentariu_capitol
      @comentariu_capitol = ComentariuCapitol.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comentariu_capitol_params
      params.require(:comentariu_capitol).permit(:user_id, :capitol_id, :continut)
    end
end
