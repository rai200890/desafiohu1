require 'thor/rails'
require 'csv'
class Seed < Thor
  include Thor::Rails
  desc "hotels", "seed hotels from file"
  def hotels(file)
    hotels_attributes = parse_file(file, [:id, :city_name, :hotel_name])
    hotels_attributes.each do |hotel_attributes|
      city = City.where(name: hotel_attributes[:city_name]).first_or_create
      Hotel.where(id: hotel_attributes[:id], city_id: city.id, name: hotel_attributes[:hotel_name]).first_or_create
    end
  end

  desc "availabilities", "seed availabilities from file"
  def availabilities(file)
    availabilities = parse_file(file, [:hotel_id, :day, :available])
    reject_unavailable(availabilities)
    availabilities.each {|availability| Availability.where(hotel_id: availability[:hotel_id], day: availability[:day]).first_or_create}
  end

  private

  def parse_file(file, attributes)
    result = []
    ::CSV.foreach(file){ |row| result << row_to_hash(attributes, row) }
    result
  end

  def row_to_hash(attributes, row)
    Hash[[attributes, row].transpose]
  end

  def reject_unavailable(availabilities)
    availabilities.reject!{ |attributes| attributes[:available] == '0'}
  end

end