# frozen_string_literal: true

class Task < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :task_list
  has_rich_text :content
  has_many :task_change_records
  before_update :add_change_record if :will_save_change_to_task_list_id?
  after_create :add_change_record_on_create
  has_many :task_users
  has_many :users, through: :task_users

  delegate :board, to: :task_list

  def add_change_record
    TaskChangeRecord.create(new_list: task_list.title, task: self) unless task_list_id == task_list_id_was
  end

  def add_change_record_on_create
    TaskChangeRecord.create(new_list: task_list.title, task: self)
  end

  def doing_time_hours
    return nil unless doing_time

    doing_time / 1.hour
  end

  def has_auth_to_update?(user)
    return true if creator == user

    board.author == user
  end
end
