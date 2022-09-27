module TaskListHelper 
  def task_list_new_header
    { title: 'Task list creator',
      text: 'Create a new list to organize better your tasks.',
      config: true }
  end  

  def task_list_index_header(board)
    { title: 'Task lists',
      text: "You are watching task lists from '#{board.title}' board",
      config: true }
  end

  def task_list_form_return_path
    request.path == new_task_list_path ? 
      board_path(@board) : 
      task_lists_path(board_id: @task_list.board.id)
  end
end
