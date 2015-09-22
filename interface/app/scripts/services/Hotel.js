angular.
  module('huHotelSearchApp').
  service("Hotel", function($http, City){
    var self = this;

    self.getHotels = function (location) {
      return $http({
        method: "get",
        url: "http://localhost:3000/api/hotels.json",
        params: {by_city_or_hotel_name: location}
      });
    };

  });
