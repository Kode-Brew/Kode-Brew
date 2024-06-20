class ProjectMembersController < ApplicationController
  before_action :set_project_member, only: %i[show edit update destroy]

  def index
    @project = Project.find(params[:project_id])
    @project_member = ProjectMember.new
  end

  def show; end

  # def new
  #   @project_member = ProjectMember.new
  # end

  def create
    @project = Project.find(params[:project_id])
    @project_member = ProjectMember.new(project_member_params)
    @project_member.user = User.find(params[:project_member][:user])
    @project_member.project = @project

    if @project_member.save
      flash[:notice] = "Membro do projeto adicionado com sucesso."

      redirect_to project_project_members_path
    else
      flash.now[:alert] = "Erro"
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @project_member.update(project_member_params)
      flash[:notice] = "Membro do projeto editado com sucesso."

      redirect_to project_project_members_path(@project_member.project)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project_member.destroy!
    redirect_to project_project_members_path(@project_member.project)
  end

  private

  def set_project_member
    @project_member = ProjectMember.find(params[:id])
  end

  def project_member_params
    params.require(:project_member).permit(:user_type)
  end
end
