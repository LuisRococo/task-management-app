# frozen_string_literal: true

class TaskPresenter
  def initialize(task)
    @task = task
  end

  def readable_started_date
    @task.started_at.to_formatted_s(:long)
  end

  def readable_finished_date
    @task.finished_at.to_formatted_s(:long)
  end

  def readable_doing_time
    ActionController::Base.helpers.pluralize(@task.doing_time_hours, 'hour')
  end
end
