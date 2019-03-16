class UserMailer < ApplicationMailer
  def event_signup(user, event)
    @user = user
    @event = event
    mail(to: user.email, subject: "IVC Events: Thank you for signing up to #{event.title} on #{event.start_date_humanized}")
  end

  def organiser_event_signup(organiser, user, event, events_users_token = nil)
    @organiser = organiser
    @user = user
    @event = event
    @token = events_users_token
    mail(to: organiser.email, subject: "IVC Events: #{user.full_name} has signed up to #{event.title} on #{event.start_date_humanized}")
  end

  def organiser_event_opened(user, event)
    @user = user
    @event = event
    mail(to: user.email, subject: "IVC Events: The organiser has seen your signup to #{event.title} on #{event.start_date_humanized}")
  end

  def event_leave(user, event)
  	@user = user
    @event = event
    mail(to: user.email, subject: "IVC Events: You have now left the event: #{event.title} on #{event.start_date_humanized}")
  end

  def organiser_event_leave(organiser, user, event)
    @organiser = organiser
    @user = user
    @event = event
    mail(to: organiser.email, subject: "IVC Events: #{user.full_name} has now left the event #{event.title} on #{event.start_date_humanized}")
  end

  def password_reset_instructions(user)
  	@user = user
  	mail(to: user.email, subject: "Password Reset Instructions")
  end
end