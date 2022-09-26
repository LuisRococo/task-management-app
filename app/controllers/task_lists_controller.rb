class TaskListsController < ApplicationController
  def new
    @task_list = TaskList.new
  end
end
