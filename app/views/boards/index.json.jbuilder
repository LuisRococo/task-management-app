json.boards @boards do |board|
  json.id board.id
  json.title board.title
  json.author board.author.full_name
  json.public board.is_public
end
