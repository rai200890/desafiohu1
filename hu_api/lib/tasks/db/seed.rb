require 'thor/rails'
require 'thor/group'
require 'csv'
module Db
  class Seed < Thor::Group

    include Thor::Actions
    include Thor::Rails

    desc 'Seed database'

    class_option :hotel_file
    class_option :availability_file

    def hotels
      hotels_attributes = parse_file(options[:hotel_file], [:id, :city_name, :hotel_name])
      import_cities(hotels_attributes)
      import_hotels(hotels_attributes)
    end

    def availabilities
      availabilities_attributes = parse_file(options[:availability_file], [:hotel_id, :day, :available])
      import_availabilities(availabilities_attributes)
    end

    private

    def import_cities cities_attributes
      city_names = cities_attributes.map{ |city_attributes| city_attributes[:city_name] }.uniq
      cities = city_names.map { |city_name| ::City.new(name: city_name) }
      cities.reject!{ |city| city.persisted? }
      ::City.import cities
    end

    def import_hotels hotels_attributes
      hotels = hotels_attributes.map do |hotel_attributes|
        city = ::City.where(name: hotel_attributes[:city_name]).first
        ::Hotel.where(id: hotel_attributes[:id], city_id: city.id, name: hotel_attributes[:hotel_name]).first_or_initialize
      end
      hotels.reject!{ |city| city.persisted? }
      ::Hotel.import hotels
    end

    def import_availabilities  availabilities_attributes
      availabilities_attributes.reject!{ |attributes| attributes[:available] == '0' }
      availabilities = availabilities_attributes.map do |availability_attributes|
        ::Availability.where(hotel_id: availability_attributes[:hotel_id], day: availability_attributes[:day]).first_or_initialize
      end
      availabilities.reject!{ |availability| availability.persisted? }
      ::Availability.import availabilities
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
end