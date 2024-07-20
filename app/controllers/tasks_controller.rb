class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :set_sprint, only: %i[new create]
  before_action :set_breadcrumbs, only: %i[show]
  before_action :check_sprint_status, only: [:new, :create]


  # Displays a list of tasks
  def index
    @tasks = Task.all
  end

  # Displays details of a specific task
  def show
    add_breadcrumb "Tarefa", task_path(@task)
  end

  # Renders form to create a new task
  def new
    @task = Task.new
    @users = @sprint.project.users
  end

  # Creates a new task
  def create
    @task = Task.new(task_params)
    @task.user = User.find(params[:task][:user_id])
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
    @users = @task.sprint.project.users
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

  def set_breadcrumbs
    add_breadcrumb "Projetos", projects_path if current_user.present? && current_user.is_admin?
    add_breadcrumb @task.sprint.project.name, project_path(@task.sprint.project)
    add_breadcrumb "Sprints", project_sprints_path(@task.sprint.project)
  end

  def check_sprint_status
    @sprint = Sprint.find(params[:sprint_id])
    if @sprint.date_end < Date.today
      redirect_to project_sprints_path(@sprint.project, @sprint), alert: "Sprint finalizada. Não há como adicionar novas Tarefas."
    end
  end
end
