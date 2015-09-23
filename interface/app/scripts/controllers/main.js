'use strict';

/**
 * @ngdoc function
 * @name interfaceApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the interfaceApp
 */
angular.module('huHotelSearchApp')
  .controller('MainCtrl', function ($scope, Hotel, City) {
    $scope.searchParams = {startDate: {}, endDate: {},  undefinedDates: false};
    $scope.paginator = {currentPage: 1, maxSize: 2, numPages: 10, totalItems: 20};
    $scope.hotels = [];
    $scope.location = null;

    $scope.openStartDate = function($event) {
      $scope.searchParams.startDate.opened = true;
    };
    $scope.openEndDate = function($event) {
      $scope.searchParams.endDate.opened = true;
    };

    $scope.typeaheadSelected = function($item, $model, $label) {
      $scope.searchParams.id = $item.object.id;
    };

    $scope.search = function(){
      var start_date = $scope.searchParams.startDate.date.toLocaleDateString();
      var end_date = $scope.searchParams.endDate.date.toLocaleDateString();
      var params = {
        id: $scope.searchParams.id,
        start_date: start_date,
        end_date: end_date
      };
      Hotel.getHotelsByParams(params).success(function(response){
        $scope.hotels = response;
      });
    };

    $scope.typeaheadLocation = function(){
      return Hotel.getHotels($scope.location).then(function(hotels) {

        return hotels.data.map(function(hotel) {
          return {type: 'hotel', object: {id: hotel.id, name: (hotel.name + ',' + hotel.city_name)}}
        });

      }).then(function(hotels){
        return City.getCities($scope.location).then(function(cities){

          return cities.data.map(function(city) {
            return {type: 'city', object: {id: city.id, name: city.name}}
          }).concat(hotels);

        });
      });
    };

  });
