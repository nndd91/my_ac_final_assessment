class LikesController < ApplicationController
  before_action :set_note, only: [:create, :destroy]

  def create
    current_user.like(@note)
    StatusUpdateMailer.likes_update_email(current_user, @note, "liked").deliver_now
    redirect_back(fallback_location: root_path)
  end

  def destroy
    current_user.unlike(@note)
    StatusUpdateMailer.likes_update_email(current_user, @note, "unliked").deliver_now
    redirect_back(fallback_location: root_path)
  end

  private

  def set_note
    @note = Note.find(params[:note_id])
  end
end
