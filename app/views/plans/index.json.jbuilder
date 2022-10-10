json.plans @plans do |plan|
  json.id plan.id
  json.title plan.title
  json.member_quantity plan.member_quantity
  json.price plan.price.format
  json.price_currency plan.price_currency
  json.time_months plan.time_months
end
