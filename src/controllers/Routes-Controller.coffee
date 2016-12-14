angular.module('MM_Graph')
  .controller 'RoutesController', ($scope, API)->
    API.routes (data)->
      $scope.routes = data