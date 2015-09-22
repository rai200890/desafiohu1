json.array! @hotels do |hotel|
  json.id hotel.id
  json.name hotel.name
  json.city_id hotel.city_id
  json.city_name hotel.city.name
end