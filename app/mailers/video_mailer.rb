# coding: UTF-8

class VideoMailer < ActionMailer::Base
  default :from => "test@local.lan"
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.confirm.subject
  #
  def welcome_email(user)
    @user=user
    @url  = "http://strong-flower-5407.heroku.com/"
    mail(:to => user.person.email, :subject => "Welcome to my Scripting Application")
  end
  
  def new_video_mail(video)
    @video=video
    @person=video.user.person
    @url  = "http://strong-flower-5407.heroku.com/"
    mail(:to => video.advisor.person.email, :subject => "Neuer Beitrag angelegt")
  end
  
  def changed_state_mail(video)
    @video=video
    @person=video.user.person
    @url  = "http://strong-flower-5407.heroku.com/"
    mail(:to => video.advisor.person.email, :subject => "Video Status geändert")
  end 
end
