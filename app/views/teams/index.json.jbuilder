json.team_members @team do |member|
  json.id member.id
  json.email member.email
  json.full_name member.full_name
  json.manager_id member.manager.id
  json.manager_name member.full_name
end
