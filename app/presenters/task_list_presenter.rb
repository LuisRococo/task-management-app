# frozen_string_literal: true

class TaskListPresenter
  def initialize(task_list)
    @task_list = task_list
  end

  def show_page_header
    { title: 'Task list information',
      text: "You are currently seeing '#{@task_list.title}' list data",
      config: true }
  end
end
