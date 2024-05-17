class ProjectMembersController < ApplicationController
  before_action :set_project_member, only: %i[show edit update destroy]

  def index
    @project_members = Project_member.all
  end

  def show; end

  def new
    @project_member = Project_member.new
  end

  def create
    @project_member = Project_member.new(project_member_params)
    @project_member.user = current_user
    if @project_member.save
      flash[:alert] = "Membro do projeto adicionado com sucesso."

      redirect_to project_members_path
    else
      render :new, status: :unprocessable_entity, alert: "nao rolou"
    end
  end

  def edit; end

  def update
    if @project_member.update(project_member_params)
      flash[:alert] = "Membro do projeto editado com sucesso."

      redirect_to project_members_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project_member.destroy!
    redirect_to project_members_path
  end

  private

  def project_member_params
    params.require(:project_member).permit(user_type)
  end

  def set_project_member
    @project_member = Project_member.find(params[:id])
  end
end
