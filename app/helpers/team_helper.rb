# frozen_string_literal: true

module TeamHelper
  def team_new_header_page
    { title: 'New team member',
      text: 'Add a new member to you team',
      config: true }
  end

  def team_index_header_page
    { title: 'Team members',
      text: 'Your teams members',
      config: true }
  end
end
