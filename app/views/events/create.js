$('input[type="text"]').val('');
$('#inputScheduleForm').modal('hide');
$('#inputEditForm').html('<%= escape_javascript(render("events/edit", events: @events )) %>');
$('#calendar').fullCalendar('refetchEvents')