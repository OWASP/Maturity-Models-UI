angular.module('MM_Graph')
  .controller 'TeamMenuController', ($scope, $routeParams)->
    $scope.team    = $routeParams.team
    $scope.project = $routeParams.project
    $scope.links =
      [
        { text: 'asdasd', path:'/aaaa/asd'}
      ]