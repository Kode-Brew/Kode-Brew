class ProjectStepsController < Wicked::WizardController
  steps :info, :customer, :members

  def show
    @project = Project.new
    render_wizard
  end

  def update
    # raise
    @project = Project.find(params[:project_id])
    @project.update(project_params)
    render_wizard @project
  end

  private

  def project_params
    params.require(:project).permit(:client_id, :name, :category, :description, :user_type, user_ids: [])
  end

  # def redirect_to_finish_wizard
  #   redirect_to root_url, notice: "Projeto salvo"
  # end
end
