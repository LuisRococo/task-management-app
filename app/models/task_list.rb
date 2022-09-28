class TaskList < ApplicationRecord
  belongs_to :board
  has_many :tasks
  alias_attribute :title, :name
end
