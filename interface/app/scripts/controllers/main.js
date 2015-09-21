'use strict';

/**
 * @ngdoc function
 * @name interfaceApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the interfaceApp
 */
angular.module('huHotelSearchApp')
  .controller('MainCtrl', function ($scope) {
    $scope.startDate = {};
    $scope.endDate = {};

    $scope.openStartDate = function($event) {
      $scope.startDate.opened = true;
    };
    $scope.openEndDate = function($event) {
      $scope.endDate.opened = true;
    };
  });
