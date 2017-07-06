class StatusUpdateMailer < ApplicationMailer
  default from: 'shopstickydevs@gmail.com'

  def likes_update_email(user, note, like)
    @user = note.user
    @user2 = user
    @note = note
    @like = like
    mail(to: @user.email, subject: "#{@user2.username} has just #{@like} your note!")
  end

  def follow_update_email(user1, user2, follow)
    @user1 = user1
    @user2 = user2
    @follow = follow
    mail(to: user1.email,subject: "#{@user2.username} has just #{@follow} you!")
  end
end
