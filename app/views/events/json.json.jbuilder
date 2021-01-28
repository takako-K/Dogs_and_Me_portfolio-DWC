json.array!(@events) do |event|
  json.extract! event, :id, :title, :body
  json.start event.start.strftime("%Y-%m-%d %H:%M")
  json.end event.end.strftime("%Y-%m-%d %H:%M")
end
