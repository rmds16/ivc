class UserMailer < ApplicationMailer

  def event_signup(user, event)
  	@user = user
    @event = event
    mail(to: user.email, subject: "IVC Events: Thank you for signing up to #{event.title}")
  end

  def organiser_event_signup(organiser, user, event)
    @organiser = organiser
    @user = user
    @event = event
    mail(to: organiser.email, subject: "IVC Events: #{user.full_name} has signed up to #{event.title}")
  end
end