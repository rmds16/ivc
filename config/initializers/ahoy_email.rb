class EmailSubscriber
  def open(event)
    event_users = EventsUser.find_by(id: event[:message]&.events_users_id)
    return if event_users&.organiser_read?
    event = event_users&.attended_event
    user = event_users&.attendee
    event_users.update_attribute(:organiser_read, true)
    UserMailer.organiser_event_opened(user, event).deliver_now
  end
end

AhoyEmail.subscribers << EmailSubscriber.new