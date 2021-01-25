// 登録後フォームを空にする
$('input[type="text"]').val('')
// モーダルフォームを消す
$('#inputScheduleForm').modal('hide');
// 登録した予定を差し替える
$('#inputEditForm').html('<%= escape_javascript(render("events/edit", events: @events )) %>');
// カレンダーの再表示
$('#calendar').fullCalendar('refetchEvents')