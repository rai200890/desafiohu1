angular.
  module('huHotelSearchApp').
  service("Location", function(Hotel, City){
    var self = this;
    self.typeahead = function (location) {
      return Hotel.getHotels(location).then(function(hotels) {
        return hotels.data.map(function(hotel) {
          return {type: 'hotel', object: {id: hotel.id, name: (hotel.name + ',' + hotel.city_name)}}
        });
      }).then(function(hotels){
        return City.getCities(location).then(function(cities){
          return cities.data.map(function(city) {
            return {type: 'city', object: {id: city.id, name: city.name}}
          }).concat(hotels);
        });
      });
    };

  });
