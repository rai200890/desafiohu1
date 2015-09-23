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

    self.getHotelsByParams = function(params){
      var url = "http://localhost:3000/api/hotels.json?";

      if (params.id) {
        url += 'by_id=' + params.id;
      }
      if (params.city_id) {
        url += 'by_city_id=' + params.city_id;
      }

      if (params.start_date && params.end_date){
        url += '&available_from_until[start_date]='+ params.start_date;
        url += '&available_from_until[end_date]='+ params.end_date;
      }
      return $http({
        method: "GET",
        url: url });
    }
  });
