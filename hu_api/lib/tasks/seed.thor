require 'thor/rails'
require 'csv'
class Seed < Thor
  include Thor::Rails

  desc "hotels", "seed hotels from file"
  def hotels(file)
    hotels_attributes = parse_file(file, [:id, :city_name, :hotel_name])
    import_cities(hotels_attributes)
    import_hotels(hotels_attributes)
  end

  desc "availabilities", "seed availabilities from file"
  def availabilities(file)
    availabilities_attributes = parse_file(file, [:hotel_id, :day, :available])
    import_availabilities(availabilities_attributes)
  end

  private

  def import_cities hotels_attributes
    city_names = hotels_attributes.map{ |hotel_attributes| hotel_attributes[:city_name] }.uniq
    cities = city_names.map { |city_name| City.new(name: city_name) }
    cities.reject!{ |city| city.persisted? }
    City.import cities
  end

  def import_hotels hotels_attributes
    hotels = hotels_attributes.map do |hotel_attributes|
      city = City.where(name: hotel_attributes[:city_name]).first
      Hotel.where(id: hotel_attributes[:id], city_id: city.id, name: hotel_attributes[:hotel_name]).first_or_initialize
    end
    hotels.reject!{ |city| city.persisted? }
    Hotel.import hotels
  end

  def import_availabilities  availabilities_attributes
    availabilities_attributes.reject!{ |attributes| attributes[:available] == '0' }
    availabilities = availabilities_attributes.map do |availability_attributes|
      Availability.where(hotel_id: availability_attributes[:hotel_id], day: availability_attributes[:day]).first_or_initialize
    end
    availabilities.reject!{ |availability| availability.persisted? }
    Availability.import availabilities
  end

  def parse_file(file, attributes)
    result = []
    ::CSV.foreach(file){ |row| result << row_to_hash(attributes, row) }
    result
  end

  def row_to_hash(attributes, row)
    Hash[[attributes, row].transpose]
  end

end