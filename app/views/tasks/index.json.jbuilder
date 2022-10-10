json.tasks @tasks do |task|
  json.id task.id
  json.title task.title
  json.creator_id task.creator.id
  json.creator_name task.creator.full_name
  json.task_list_id task.task_list_id
  json.completed task.completed
end
