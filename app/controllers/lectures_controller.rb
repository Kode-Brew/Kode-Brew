class LecturesController < ApplicationController
  before_action :set_lecture, only: %i[show edit update destroy]

  def index
    @lectures = Lecture.all
  end

  def show
  end

  def new
    @lecture = Lecture.new
  end

  def create
    @lecture = Lecture.new(params_lecture)

    if @lecture.save
      redirect_to lecture_path(@lecture.id),
                  notice: 'Aula criado com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

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

  def set_lecture
    @lecture = Lecture.find(params[:id])
  end
end
