class ProjectMembersController < ApplicationController
  before_action :set_project_member, only: %i[show edit update destroy]
  before_action :set_project_member, only: %i[index new create]

  def index
    @project_members = ProjectMember.all
  end

  def show; end

  def new
    @project_member = ProjectMember.new
  end

  def create
    @project_member = ProjectMember.new(project_member_params)
    @project_member.user_id = current_user.id
    @project_member.project_id = params[:project_id]

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

  def set_project_member
    @project_member = ProjectMember.find(params[:id])
  end

  def project_member_params
    params.require(:project_member).permit(:user_id, :project_id, :user_type)
  end

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_user
    @user = User.find(params[:user_id])
  end
end
