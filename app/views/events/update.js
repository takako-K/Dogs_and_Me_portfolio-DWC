$('#inputEditForm').html('<%= escape_javascript(render("events/edit", events: @events)) %>');
$('.modal-backdrop').remove();
$('#calendar').fullCalendar('refetchEvents')