class TodosController < ApplicationController
  before_filter :check_if_owner, only: [:show, :edit, :update, :destroy]
  before_filter :check_if_student, only: [:index, :new, :create]
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  # GET /todos
  # GET /todos.json
  def index
    # @todos = Todo.all
  end

  # GET /todos/1
  # GET /todos/1.json
  def show
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1/edit
  def edit
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(todo_params)

    if get_current_user.rol == "Student" and Licenta.find(Capitol.find(@todo.capitol_id).licenta_id).user_id == get_current_user.id
    respond_to do |format|
      if @todo.save
        format.html { redirect_to root_path, notice: 'Todo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @todo }
      else
        format.html { render action: 'new' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
    end
  end

  # PATCH/PUT /todos/1
  # PATCH/PUT /todos/1.json
  def update
    respond_to do |format|
      if @todo.update(todo_params)
        format.html { redirect_to root_path, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo.destroy
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end

  protected

  def check_if_owner
    @capitol = Capitol.find(params[:id])
    if get_current_user
      licenta_capitol_id = @capitol.licenta_id
      # licenta studentului logat trebuie sa fie aceeasi cu licenta capitolului pe care il acceseaza 
      if get_current_user.rol == "Student"
        licenta = Licenta.where(user_id: get_current_user.id, sesiune_id: get_current_sesiune.id).first
        if licenta
          if licenta.id != licenta_capitol_id
            redirect_to root_path
          end
        else
          redirect_to root_path
        end
      else
        redirect_to root_path
      end # end of if rol
    else
      redirect_to root_path
    end # end of if current user
  end

  def check_if_student
    if get_current_user
      if get_current_user.rol != "Student"
        redirect_to root_path
      end
    end
  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = Todo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def todo_params
      params.require(:todo).permit(:capitol_id, :continut, :este_gata)
    end
end
