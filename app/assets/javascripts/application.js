// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
//= require moment
//= require bootstrap-datetimepicker
//= require fullcalendar
//= require select2

$(document).ready(function() {

  $('#calendar').fullCalendar({
    editable: true,
    selectable: true,
    displayEventTime: false,
    eventSources: [
      // your event source
      {
        url: '/events/',
        color: 'white',
        textColor: 'black'
      }
    ],

    eventRender: function(event, element) {
      $(element).tooltip({title: event.title, container: 'body'});             
    },

    dayClick: function(date, jsEvent, view) {
      window.location.href = "events/new?date=" + date.format();
    }
  });

  $('.datetimepicker').datetimepicker({format: "YYYY-MM-DD HH:mm"} );
  $('.datepicker').datetimepicker({format: "YYYY-MM-DD"});

  $('#event_organiser_id').select2({theme: 'bootstrap'});
  $('#event_second_organiser_id').select2({theme: 'bootstrap'});

  $('#event_organiser_id').on("select2:select", function (e) {
     user_id = $('#event_organiser_id').val();
     $.getJSON('/users/' + user_id + '/user_details', function(jd) {
        $('#event_organiser_email').val(jd.email);
        $('#event_organiser_phone').val(jd.phone);
     });
  });

  $('#event_second_organiser_id').on("select2:select", function (e) {
     user_id = $('#event_second_organiser_id').val();
     $.getJSON('/users/' + user_id + '/user_details', function(jd) {
        $('#event_second_organiser_email').val(jd.email);
        $('#event_second_organiser_phone').val(jd.phone);
     });
  });
});

//= require turbolinks
//= require_tree .
