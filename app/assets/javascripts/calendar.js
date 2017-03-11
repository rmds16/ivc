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
      $(element).tooltip({title: event.tooltip, container: 'body'});             
    },

    dayClick: function(date, jsEvent, view) {
      window.location.href = "events/new?date=" + date.format();
    }
  });

  if($('#calendar').data('date')) {
    var show_date = $.fullCalendar.moment($('#calendar').data('date'));
    if (show_date) {
      $('#calendar').fullCalendar('gotoDate', show_date);
    }
  }

  $('#search-title').autocomplete({
    source: "/events/search_title",
    minLength: 2,
    html: true
  });

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

  $('.repeat-toggle').on('click', function (e) {
    $('.repeat-dropdown').toggle(800);
    e.preventDefault();
  });

  $( function() {
    $( "#tabs" ).tabs();
  });

  $('textarea').autosize();

  $(document).on("click",".modify-event-link",function() {
    $('#form_modify_event').click();
  });

  $(document).on("click","#no_book_by_date",function(e) {
    var date_select = $(e.target).closest('.row').find('.rails-bootstrap-forms-date-select').find('select');
    if (date_select) {
      if($(e.target).prop('checked')){
        date_select.prop("disabled", true);
      }
      else {
        date_select.prop("disabled", false);
      }
    }
  });
});