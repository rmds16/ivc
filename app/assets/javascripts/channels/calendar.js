App.calendar = App.cable.subscriptions.create("CalendarChannel", {
  connected: function() {
  },

  disconnected: function() {
  },

  received: function(data) {
    $('#calendar').fullCalendar('refetchEvents');
  }
});
