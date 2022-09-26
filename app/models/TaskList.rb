class TaskList < ApplicationRecord
  belongs_to :board

  alias_attribute :title, :name
end
