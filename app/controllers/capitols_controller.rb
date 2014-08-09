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
      @u = current_user
      @fisierele = Fisier.where(capitol_id: @capitol.id)
      @todouri = Todo.where(capitol_id: @capitol.id)
      @comentarii = ComentariuCapitol.where(capitol_id: @capitol.id)
      @studentid = Licenta.find(@capitol.licenta_id).user_id
  end
  
  def adauga_comentariu
      ComentariuCapitol.create(continut: params[:comentariu], user_id: current_user.id, capitol_id: params[:capitol])
      redirect_to Capitol.find(params[:capitol])
  end

  # GET /capitols/new
  def new
    @u = current_user
    @capitol = Capitol.new
    licenta_id = Licenta.where(user_id: @u.id)
    @capitole = Capitol.where(licenta_id: licenta_id)
  end

  # GET /capitols/1/edit
  def edit
    @u = current_user
  end

  # POST /capitols
  # POST /capitols.json
  def create
    @capitol = Capitol.new(capitol_params)

    respond_to do |format|
      if @capitol.save

        # actualizeaza numerele la restul capitolelor de dupa asta nou
        if Capitol.where("numar = ?", "#{@capitol.numar}").count > 1
          @capitole = Capitol.where("numar >= ? and id != ?", "#{@capitol.numar}", "#{@capitol.id}")
          @capitole.each do |cap|
            numar = cap.numar + 1
            cap.update_attributes(numar: numar)
          end
        end

        format.html { redirect_to root_path, notice: 'Capitol was successfully created.' }
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
        format.html { redirect_to root_path, notice: 'Capitol was successfully updated.' }
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
    capitol_id = @capitol.id
    licenta_id = @capitol.licenta_id
    numar = @capitol.numar
    @capitol.destroy

    # actualizeaza numerele la restul capitolelor de dupa asta distrus
    @capitole = Capitol.where("licenta_id = ? and numar > ?", "#{licenta_id}", "#{numar}")
    if @capitole.count > 0
      @capitole.each do |cap|
        cap.update_attributes(numar: cap.numar-1)
      end
    end

    # sterge si todo-urile capitolului aluia din baza de date
    Todo.where(capitol_id: capitol_id).delete_all

    respond_to do |format|
      format.html { redirect_to root_path }
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
