class Board < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_many :task_lists, dependent: :destroy
end
