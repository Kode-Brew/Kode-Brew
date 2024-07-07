class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show edit update destroy]
  before_action :set_breadcrumbs, except: %i[show update destroy]

  def index
    @lectures = Lecture.all
  end

  def show
    if params[:sprint].present?
      @sprint = Sprint.find(params[:sprint])
      add_breadcrumb "Projetos", projects_path
      add_breadcrumb @sprint.project.name, project_path(@sprint.project)
      add_breadcrumb "Sprints", project_sprints_path(@sprint.project, @sprint)
      add_breadcrumb "Aulas da Sprint", project_sprint_sprint_lectures_path(@sprint.project, @sprint)
    else
      add_breadcrumb "Aulas", lectures_path
    end
    add_breadcrumb @lecture.title, lecture_path(@lecture)
  end

  def new
    add_breadcrumb "Nova Aula", new_lecture_path
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(params_lecture)
    if params[:lecture][:user_id].present?
      @lecture.user = User.find(params[:lecture][:user_id])
    end
    if @lecture.save
      redirect_to lecture_path(@lecture.id),
                  notice: 'Aula criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    add_breadcrumb @lecture.title, lecture_path(@lecture)
    add_breadcrumb "Editar Aula", edit_lecture_path(@lecture)
  end

  def update
    if params[:lecture][:user_id].present?
      @lecture.user = User.find(params[:lecture][:user_id])
    end
    if @lecture.update!(params_lecture)
      redirect_to lecture_path(@lecture), notice: "Aula atualizada com sucesso."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lecture.destroy
    redirect_to lectures_path, status: :see_other
  end

  private

  def params_lecture
    params.require(:lecture).permit(:title, :source, :video, :slide, :description, :tag)
  end

  def set_breadcrumbs
    add_breadcrumb "Aulas", lectures_path
  end

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end
end
