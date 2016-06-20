angular.module('MM_Graph')
  .controller 'TopNavBarController', ($scope, $routeParams)->
    $scope.team    = $routeParams.team
    $scope.project = $routeParams.project