class ProjectsController < ApplicationController
  before_action :set_project, only: %i[show sprint edit update destroy]

  def index
    @projects = Project.all
  end

  def show; end

  # view temporária para gerar a view de sprints e tasks no show de project
  def sprint; end

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
end
