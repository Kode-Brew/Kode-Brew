class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show edit update destroy]
  before_action :set_breadcrumbs, except: %i[update destroy]

  def index
    @lectures = Lecture.all
  end

  def show
    add_breadcrumb @lecture.title, lecture_path(@lecture)
  end

  def new
    add_breadcrumb "Nova Aula", new_lecture_path
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(params_lecture)
    @lecture.user = User.find(params[:lecture][:user_id])
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
