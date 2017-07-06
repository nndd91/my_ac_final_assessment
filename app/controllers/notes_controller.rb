class NotesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  def index
    @notes = Note.all
    @users = User.all
  end

  def show
  end

  def new
    @note = current_user.notes.build
  end

  def create
    @note = current_user.notes.build(notes_params)
    if @note.save
      redirect_to note_path(@note)
    else
      render :new
    end
  end

  def edit
  end

  def update
    @note.update(notes_params)
    redirect_to edit_note_path(@note)
  end

  def destroy
    @note.destroy
    redirect_to notes_path
  end

  private

  def notes_params
    params.require(:note).permit(:content)
  end

  def set_note
    @note = Note.find(params[:id])
  end

end
