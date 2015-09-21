'use strict';

/**
 * @ngdoc function
 * @name interfaceApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the interfaceApp
 */
angular.module('huHotelSearchApp')
  .controller('MainCtrl', function ($scope, Hotel) {

    $scope.startDate = {};
    $scope.endDate = {};

    $scope.undefinedDates = false;

    $scope.openStartDate = function($event) {
      $scope.startDate.opened = true;
    };
    $scope.openEndDate = function($event) {
      $scope.endDate.opened = true;
    };

    $scope.typeaheadLocation = function(){
      return Hotel.getHotels().then(function(response) {
        return response.data.map(function (item) {
          return item.name;
        });
      });
    };

  });
