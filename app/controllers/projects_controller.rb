class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy advance_sprint finish_project]
  before_action :set_breadcrumbs, except: %i[myprojects update destroy advance_sprint finish_project]
  before_action :authenticate_admin, only: %i[index new create edit update destroy]

  # helper :breadcrumbs

  def index
    @projects = Project.all
    filter_projects
  end

  def myprojects
    add_breadcrumb "Meus projetos", myprojects_path
    @projects = current_user.projects.select('projects.*, project_members.user_type')

    filter_projects
  end

  def dashboard
    add_breadcrumb "Dashboard", dashboard_path
    @project = current_user.projects.find_by(is_active?: true)
  end

  def show
    add_breadcrumb "Meus projetos", myprojects_path
    add_breadcrumb @project.name, project_path(@project)
  end

  def new
    add_breadcrumb "Novo Projeto", new_project_path

    @project = Project.new
    @project.project_members.build # Isso cria um objeto vazio para o nested form
  end

  def create
    @project = Project.new(project_params)

    if @project.save
      create_project_members if project_members_params_present?
      redirect_to projects_path, notice: 'Projeto criado com sucesso.'
    else
      render :new, status: :unprocessable_entity, notice: 'Não foi possível criar o projeto.'
    end
    puts @project.errors.full_messages
  end

  def edit
    add_breadcrumb @project.name, project_path(@project)
    add_breadcrumb "Editar Projeto", edit_project_path(@project)
  end

  def update
    if @project.update(project_params)
      flash[:notice] = "Projeto editado com sucesso."

      redirect_to projects_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy!
    redirect_to projects_path
  end

  def advance_sprint
    if @project.active_sprint.to_i < @project.sprints.count
      @project.update(active_sprint: @project.active_sprint.to_i + 1)
    end
    redirect_back(fallback_location: project_sprints_path(@project), notice: 'Sprint avançada com sucesso.')
  end

  def finish_project
    # 0 = pendent, 1 = in progress, 2 = finished
    @project.update(status: 2)
    redirect_to project_path(@project), notice: 'Projeto finalizado com sucesso.'
  end


  private

  def set_project
    @project = Project.find(params[:id])
  end

  def set_breadcrumbs
    add_breadcrumb "Projetos", projects_path if current_user.present? && current_user.is_admin?
  end

  def project_params
    params.require(:project).permit(:client_id, :name, :category, :description, :status, project_members_attributes: [:user_id, :user_type])
  end

  def filter_projects
    if params[:filter].present?
      @projects = @projects.select { |project| project.status == params[:filter] }
    end
  end

  def project_members_params_present?
    params.dig(:project, :project_members_attributes, :user_id).present?
  end

  def create_project_members
    project_member_params = params[:project][:project_members_attributes]
    ProjectMember.create(
      user_id: project_member_params[:user_id],
      project: @project,
      user_type: project_member_params[:user_type]
    )
  end
end
