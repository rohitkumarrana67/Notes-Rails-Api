class NotesController < ApplicationController

  before_action :get_note, only: [:update,:show,:destroy]

  def index
    @notes=Note.all
    render json: @notes , status: :ok
  end 

  def create 
    @note= Note.create(
      title:params[:title],
      content:params[:content]
    )

    if @note.errors.present?
      render json: {error:@note.errors},status: :unprocessable_entity
    else
      render json: @note.as_json(only: [:id,:title,:content]), status: :created
    end
  end

  def show
    render json: @note.as_json(only: [:id,:title,:content]), status: :ok
  end

  def update 
    if @note.update(note_params)
      render json: @note.as_json(only: [:id,:title,:content]), status: :ok
    else
      render json: {error:@note.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @note.destroy()
    render json: @note , status: :ok
  end

  private

  def get_note
    @note=Note.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:title,:content)
  end

end