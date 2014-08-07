class AlegeriUserTemasController < ApplicationController
  before_action :set_alegeri_user_tema, only: [:show, :edit, :update, :destroy]

  # GET /alegeri_user_temas
  # GET /alegeri_user_temas.json
  def index
    @alegeri_user_temas = AlegeriUserTema.all
  end

  # GET /alegeri_user_temas/1
  # GET /alegeri_user_temas/1.json
  def show
    @u = current_user
  end

  # GET /alegeri_user_temas/new
  def new
    @from = params[:from]
    @alegeri_user_tema = AlegeriUserTema.new
  end

  # GET /alegeri_user_temas/1/edit
  def edit
     @u = current_user
     @from = params[:from]
  end

  # POST /alegeri_user_temas
  # POST /alegeri_user_temas.json
  def create
    @alegeri_user_tema = AlegeriUserTema.new(alegeri_user_tema_params)

    respond_to do |format|
      if @alegeri_user_tema.save
        format.html { redirect_to @alegeri_user_tema, notice: 'Alegeri user tema was successfully created.' }
        format.json { render action: 'show', status: :created, location: @alegeri_user_tema }
      else
        format.html { render action: 'new' }
        format.json { render json: @alegeri_user_tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alegeri_user_temas/1
  # PATCH/PUT /alegeri_user_temas/1.json
  def update
    if params[:Titlu] && params[:Catre] && params[:Mesaj]
        UserMailer.notification_email(User.find(current_user.id).email,params[:Catre], params[:Titlu], params[:Mesaj]).deliver
    end
    respond_to do |format|
      if @alegeri_user_tema.update(alegeri_user_tema_params)
        format.html { redirect_to studentiiMei_path, notice: 'Cererea a fost actualizata.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @alegeri_user_tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alegeri_user_temas/1
  # DELETE /alegeri_user_temas/1.json
  def destroy
    @alegeri_user_tema.destroy
    respond_to do |format|
      format.html { redirect_to alegeri_user_temas_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alegeri_user_tema
      @alegeri_user_tema = AlegeriUserTema.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alegeri_user_tema_params
      params.require(:alegeri_user_tema).permit(:user_id, :tema_id, :status_profesor, :status_student)
    end
end
