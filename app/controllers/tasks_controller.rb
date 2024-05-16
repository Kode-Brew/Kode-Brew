class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @task.user = current_user
    @task.sprint = Sprint.first
    if @task.save
      flash[:alert] = "Tarefa criada com sucesso."

      redirect_to tasks_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:alert] = "tarefa editada  com sucesso."

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
