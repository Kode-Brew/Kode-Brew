class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_sprint, only: %i[new create]

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
    @project_members = @sprint.project.project_members
    @users = @project_members.map(&:user) if @project_members
  end

  # Creates a new task
  def create
    @task = Task.new(task_params)
    @task.user = User.find(params[:task][:user_id])
    @task.sprint = @sprint
    @task.project_member = @sprint.project.project_members.find_by(user_id: @task.user)
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

      redirect_to project_sprints_path(@task.sprint.project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Deletes a task
  def destroy
    @task.destroy!
    redirect_to project_sprints_path(@task.sprint), status: :see_other
  end

  private

  # Permits task parameters
  def task_params
    params.require(:task).permit(:name, :priority, :description, :status, :points, :user_id)
  end

  # Sets the task instance variable based on the provided id
  def set_task
    @task = Task.find(params[:id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end
end
