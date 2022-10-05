class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task_list
  has_rich_text :content
  has_many :task_change_records
  before_update :add_change_record if :will_save_change_to_task_list_id?
  after_create :add_change_record_on_create
  has_many :task_users
  has_many :users, through: :task_users

  def board
    task_list.board
  end

  def add_change_record
    unless task_list_id == task_list_id_was
      TaskChangeRecord.create(new_list: self.task_list.title, task: self)
    end
  end

  def add_change_record_on_create
    TaskChangeRecord.create(new_list: self.task_list.title, task: self)
  end

  def doing_time_hours
    return nil unless doing_time
    doing_time / 1.hour
  end
end
