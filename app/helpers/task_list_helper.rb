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
end
