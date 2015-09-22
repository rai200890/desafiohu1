angular.
  module('huHotelSearchApp').
  service("City", function($http){
    var self = this;

    self.getCities = function (location) {
      return $http({
        method: "get",
        url: "http://localhost:3000/api/cities.json",
        params: {by_city_name: location}
      });
    };

  });
