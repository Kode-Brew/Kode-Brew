class SprintsController < ApplicationController
  before_action :set_sprint, only: [:show, :edit, :update, :destroy]
  before_action :set_project, only: [:index, :new, :create]


  # Displays list of a Project's Sprint
  def index
    @sprints = Sprint.all.reverse_order
  end

  # Displays detailed Sprint
  def show
    # Pelo desenho feito anteriormente, não há necessidade de 'show de sprints'
  end

  # Form to create new Sprint
  def new
    @sprint = Sprint.new
  end

  # Creates (post) new Sprint
  def create
    @sprint = Sprint.new(sprint_params)
    @sprint.project = @project

    if @sprint.save
      flash[:notice] = "Nova Sprint criada com sucesso."
      redirect_to project_sprints_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  # Form to edit a Sprint
  def edit
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
end
