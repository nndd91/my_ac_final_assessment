class LikesController < ApplicationController
  before_action :set_note, only: [:create, :destroy]

  def create
    current_user.like(@note)
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unlike(@note)
    redirect_back(fallback_location: root_path)
  end

  private

  def set_note
    @note = Note.find(params[:note_id])
  end
end
