class SprintLecturesController < ApplicationController
  before_action :set_sprint_lecture, only: %i[show edit update destroy]
  before_action :set_sprint, only: %i[new create index]
  before_action :set_breadcrumbs
  def index
    add_breadcrumb "Aulas da Sprint", project_sprint_sprint_lectures_path(@sprint.project, @sprint)
    @lectures = @sprint.lectures
  end

  def show; end

  def new
    @sprint_lecture = SprintLecture.new
  end

  def create
    @sprint_lecture = SprintLecture.new
    @sprint_lecture.sprint = Sprint.find(params[:sprint_id])
    @sprint_lecture.lecture = Lecture.find(params[:sprint_lecture][:lecture])
    if @sprint_lecture.save
      flash[:notice] = "Membro do projeto adicionado com sucesso."

      redirect_to project_sprints_path(@sprint_lecture.sprint.project, @sprint_lecture.sprint)
    else
      flash.now[:alert] = "Erro"
      render :index, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @sprint_lecture.update(sprint_lecture_params)
      flash[:notice] = "Membro do projeto editado com sucesso."

      redirect_to sprint_sprint_lectures_path(@sprint_lecture.sprint)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sprint_lecture.destroy!
    redirect_to project_sprints_path(@sprint_lecture.sprint.project, @sprint_lecture.sprint)
  end

  private

  def set_sprint_lecture
    @sprint_lecture = ProjectMember.find(params[:id])
  end

  def set_sprint
    @sprint = Sprint.find(params[:sprint_id])
  end

  def set_breadcrumbs
    add_breadcrumb "Projetos", projects_path
    add_breadcrumb @sprint.project.name, project_path(@sprint.project)
    add_breadcrumb "Sprints", project_sprints_path(@sprint.project, @sprint)
  end
end
