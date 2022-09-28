module TaskHelper
  def task_new_header
    { title: 'Tasks',
      text: 'Create a new task and start working on it.',
      config: true }
  end

  def task_edit_header
    { title: 'Tasks',
      text: 'Edit a task',
      config: true }
  end

  def task_index_header(task_list)
    { title: 'Tasks',
      text: "You are watching all the tasks from #{task_list.title} list",
      config: true }
  end

  def task_form_models
    @task&.id.nil? ? [@task_list, @task] : [@task]
  end

  def task_form_task_lists
    @task&.id.nil? ? @task_list.board.task_lists : @task.board.task_lists
  end
end
