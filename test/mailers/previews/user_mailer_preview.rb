# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def event_signup
  	user = User.last
    event = Event.last
    UserMailer.event_signup(user, event)
  end

  def organiser_event_signup
  	user = User.last
    event = Event.last
    UserMailer.organiser_event_signup(user, user, event)
  end
end
