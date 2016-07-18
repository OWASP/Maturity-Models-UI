angular.module('MM_Graph')
  .controller 'RoutesController', ($scope, MM_API)->
    MM_API.routes (data)->
      $scope.routes = data