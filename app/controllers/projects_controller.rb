class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show edit update destroy]

  def index
    @projects = Project.all
    filter_projects
  end

  def myprojects
    @projects = current_user.projects
                            .left_joins(:project_members, sprints: :tasks)
                            .group('projects.id', 'project_members.user_type')
                            .select('projects.*, project_members.user_type,
                                    SUM(CASE WHEN tasks.status = \'finalizada\' THEN tasks.points ELSE 0 END) AS total_points,
                                    COUNT(CASE WHEN tasks.status = \'finalizada\' THEN 1 ELSE NULL END) AS tasks_performed')

    filter_projects
  end

  def dashboard
    @project = current_user.projects.find_by(is_active?: true)
  end

  def show; end

  def new
    @project = Project.new
  end

  def create
    @project_member = current_user
    @project = Project.new(project_params)

    if @project.save
      flash[:notice] = "Projeto criado com sucesso."

      redirect_to projects_path
    else
      render :new, status: :unprocessable_entity, alert: "nao rolou"
    end
    puts @project.errors.full_messages
  end

  def edit; end

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


  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:client_id, :name, :category, :description)
  end

  def filter_projects
    if params[:filter].present?
      @projects = @projects.select { |project| project.status == params[:filter] }
    end
  end
end
