json.task_lists @task_lists do |task_list|
  json.id task_list.id
  json.name task_list.name
  json.color task_list.color
  json.priority task_list.priority
  json.board_id task_list.board_id
end
