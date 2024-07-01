class ProjectStepsController < ApplicationController
  include Wicked::Wizard
  steps :info, :customer, :members

  def show
    @project = Project.find_by(params[:project_id])
    render_wizard
  end

  def update
    @project = Project.find_by(params[:project_id])
    @project.update(project_params)
    render_wizard @project
  end

  private

  def project_params
    params.require(:project).permit(:client_id, :name, :category, :description, user_ids: [])
  end

  # def redirect_to_finish_wizard
  #   redirect_to root_url, notice: "Projeto salvo"
  # end
end
