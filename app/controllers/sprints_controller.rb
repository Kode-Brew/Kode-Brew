class SprintsController < ApplicationController
  before_action :set_sprint, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :new, :create]
  before_action :set_breadcrumbs, except: %i[update destroy show edit]


  # Displays list of a Project's Sprint
  def index
    @sprints = Sprint.all
  end

  # Displays detailed Sprint
  def show
    add_breadcrumb @sprint.project.name, project_path(@sprint.project)
    add_breadcrumb "Sprints", project_sprints_path(@sprint.project)
    add_breadcrumb "Sprint #{@sprint.project.position(@sprint)}", sprint_path(@sprint)
  end

  # Form to create new Sprint
  def new
    add_breadcrumb "Nova Sprint", new_project_sprint_path
    @sprint = Sprint.new
  end

  # Creates (post) new Sprint
  def create
    @sprint = Sprint.new(sprint_params)
    @sprint.project = @project
    if @sprint.save
      first_sprint
      flash[:notice] = "Nova Sprint criada com sucesso."
      redirect_to project_sprints_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Form to edit a Sprint
  def edit
    add_breadcrumb @sprint.project.name, project_path(@sprint.project)
    add_breadcrumb "Sprints", project_sprints_path(@sprint.project)
    add_breadcrumb "Editar Sprint", edit_sprint_path(@sprint)
  end

  # Updates (patch) a Sprint
  def update
    if @sprint.update(sprint_params)
      flash[:notice] = "Sprint atualizada com sucesso."

      redirect_to project_sprints_path(@sprint.project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Destroy a Sprint
  def destroy
    @sprint.destroy!
    redirect_to project_sprints_path(@sprint.project), status: :see_other
  end

  private

  # Permits Sprint parameters
  def sprint_params
    params.require(:sprint).permit(:date_start, :date_end, :objective)
  end

  # Sets the Sprint instance variable based on the provided id
  def set_sprint
    @sprint = Sprint.find(params[:id])
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_breadcrumbs
    add_breadcrumb "Projetos", projects_path if current_user.present? && current_user.is_admin?
    add_breadcrumb "Meus projetos", myprojects_path
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb "Sprints", project_sprints_path
  end

  def first_sprint
    return if @project.sprints.count != 1

    @project.status = 1
    @project.save
  end
end
