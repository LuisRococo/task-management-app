module BoardHelper
  def board_index_header
    { title: 'Team Boards',
      text: 'Your team boards will appear below',
      config: false }
  end

  def board_new_header
    { title: 'New Board',
      text: 'Create a new board',
      config: true }
  end

  def board_edit_header
    { title: 'Update Board',
      text: 'Edit your board information',
      config: true }
  end

  def board_group_creator_full_name(boards)
    boards.first.author.full_name
  end

  def manager_full_name
    @manager.full_name
  end
end
