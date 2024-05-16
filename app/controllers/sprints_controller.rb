class SprintsController < ApplicationController
  before_action :set_sprint, only: [:edit, :update, :destroy]

  def index
    @sprints = Sprint.all.reverse_order
  end

  # Pelo desenho feito anteriormente, não há necessidade de 'show de sprints'
  # def show
  # end

  def new
    @sprint = Sprint.new
  end

  def create
    @sprint = Sprint.new(sprint_params)
    if @sprint.save
      redirect_to sprint_path(@sprint)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @sprint.update(sprint_params)
    redirect_to sprint_path(@sprint)
  end

  def destroy
    @sprint.destroy
    # No need for app/views/sprintss/destroy.html.erb
    redirect_to sprintss_path, status: :see_other
  end

  private

  def sprint_params
    params.require(:sprint).permit(:date_start, :date_end, :objective)
  end

  def set_sprint
    @sprint = Sprint.find(params[:id])
  end
end
