'use strict';

/**
 * @ngdoc overview
 * @name huHotelSearchApp
 * @description
 * # huHotelSearchApp
 *
 * Main module of the application.
 */
angular
  .module('huHotelSearchApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch'
  ])
  .config(function ($routeProvider, $locationProvider) {
    $routeProvider
      .when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs: 'main'
      }).otherwise({
        redirectTo: ''
      });

    $locationProvider.html5Mode({
      enabled: true,
      requireBase: true
    });
  });

