class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task_list
  has_rich_text :content
  has_many :task_change_records
  after_save :add_change_record if :will_save_change_to_task_list_id?

  def board
    task_list.board
  end

  def add_change_record
    TaskChangeRecord.create(new_list: self.task_list.title, task: self)
  end
end
