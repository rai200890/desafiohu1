'use strict';

/**
 * @ngdoc function
 * @name interfaceApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the interfaceApp
 */
angular.module('huHotelSearchApp')
  .controller('MainCtrl', function ($scope, Hotel, Location) {
    $scope.searchParams = {startDate: {}, endDate: {},  undefinedDates: false};
    $scope.paginator = {currentPage: 1, perPage: 2, totalPages: 10, totalEntries: 20};
    $scope.hotels = null;
    $scope.location = null;

    $scope.openStartDate = function($event) {
      $scope.searchParams.startDate.opened = true;
    };
    $scope.openEndDate = function($event) {
      $scope.searchParams.endDate.opened = true;
    };

    $scope.typeaheadSelected = function($item, $model, $label) {
      if ($item.type == 'hotel') {
        $scope.searchParams.id = $item.object.id;
      }
      if ($item.type == 'city') {
        $scope.searchParams.city_id = $item.object.id;
      }
    };

    $scope.search = function(){
      var params = {};
      var start_date = $scope.searchParams.startDate.date;
      var end_date = $scope.searchParams.endDate.date;

      params['id'] = $scope.searchParams.id;
      params['city_id'] = $scope.searchParams.city_id;

      if ($scope.searchParams.undefinedDates == false){
        params['start_date'] = start_date;
        params['end_date'] = end_date;
      }

      Hotel.getHotelsByParams(params).
        success(function(response, statusCode, headers){
          var headers = headers();

          $scope.paginator = {
            currentPage: headers['x-pagination-current-page'],
            perPage: headers['x-pagination-per-page'],
            totalEntries: headers['x-pagination-total-entries'],
            totalPages: headers['x-pagination-total-pages']
          };
          $scope.hotels = response;
        });
    };

    $scope.typeaheadLocation = function(){
      return Location.typeahead($scope.location);
    };

  });
