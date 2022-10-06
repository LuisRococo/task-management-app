class BoardPresenter
  def initialize(board)
    @board = board
  end

  def show_header
    { title: "#{@board.title} Board",
      text: 'Manage today´s tasks',
      config: false }
  end

  def author_full_name
    @board.author.full_name
  end

  def visibility_status
    @board.is_public ? 'Public' : 'Private'
  end
end
