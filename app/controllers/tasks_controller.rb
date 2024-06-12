class TasksController < ApplicationController
  before_action :set_project
  before_action :set_sprint
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
    @task.sprint = @sprint
    if @task.save
      flash[:notice] = "Tarefa criada com sucesso."

      redirect_to project_sprints_path
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
      flash[:notice] = "Tarefa editada com sucesso."

      redirect_to project_sprints_path(@project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a task
  def destroy
    @task.destroy!
    redirect_to project_sprint_task_path(@project)
  end

  private

  # Permits task parameters
  def task_params
    params.require(:task).permit(:name, :priority, :description, :status, :points)
  end

  # Sets the task instance variable based on the provided id
  def set_task
    @task = @sprint.tasks.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end
end
