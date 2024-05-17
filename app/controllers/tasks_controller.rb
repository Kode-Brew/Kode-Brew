class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  # Displays a list of tasks
  def index
    @tasks = Task.all
  end

  # Displays details of a specific task
  def show
  end

  # Renders form to create a new task
  def new
    @task = Task.new
  end

  # Creates a new task
  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.sprint = Sprint.first
    if @task.save
      flash[:notice] = "Tarefa criada com sucesso."

      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Renders form to edit a task
  def edit
  end

  # Updates a task
  def update
    if @task.update(task_params)
      flash[:notice] = "Tarefa editada  com sucesso."

      redirect_to tasks_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a task
  def destroy
    # @task = Task.find(params[:id])
    @task.destroy!
    redirect_to tasks_path
  end

  private

  # Permits task parameters
  def task_params
    params.require(:task).permit(:name, :priority, :description, :status, :points)
  end

  # Sets the task instance variable based on the provided id
  def set_task
    @task = Task.find(params[:id])
  end
end
