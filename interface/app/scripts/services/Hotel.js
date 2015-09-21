angular.
  module('huHotelSearchApp').
  service("Hotel", function($http){
    var self = this;

    self.getHotels = function (params) {
      return $http({
        method: "get",
        url: "http://localhost:3000/api/hotels.json",
        params: {}
      });
    }

  });
