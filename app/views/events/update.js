// 編集した内容を差し替える
$('#inputEditForm').html('<%= escape_javascript(render("events/edit", events: @events)) %>');
// モーダル背景画面を消す
$('.modal-backdrop').remove();
// カレンダーを再表示
$('#calendar').fullCalendar('refetchEvents')