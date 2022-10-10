# frozen_string_literal: true

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

  def board_author_full_name
    @author.full_name
  end

  def board_form_models
    @board&.id.nil? ? [@author, @board] : [@board]
  end

  def show_board_options?
    @board.user_access_to_options?(current_user)
  end
end
