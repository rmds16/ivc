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

  def event_leave
  	user = User.last
    event = Event.last
    UserMailer.event_leave(user, event)
  end

  def organiser_event_leave
  	user = User.last
    event = Event.last
    UserMailer.organiser_event_leave(user, user, event)
  end

  def password_reset_instructions
  	user = User.last
    UserMailer.password_reset_instructions(user)
  end
end
