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
    $scope.location = null;
    $scope.undefinedDates = false;

    $scope.openStartDate = function($event) {
      $scope.startDate.opened = true;
    };
    $scope.openEndDate = function($event) {
      $scope.endDate.opened = true;
    };

    $scope.typeaheadSelected = function($item, $model, $label) {
      $scope.hotelId = $item.id;
    };

    $scope.typeaheadLocation = function(){
      return Hotel.getHotels($scope.location).then(function(response) {
        return response.data.map(function (item) {
          return item;
        });
      });
    };

  });
