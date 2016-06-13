angular.module('MM_Graph')
  .controller 'SideNavBarController', ($scope, $routeParams)->
    $scope.target = $routeParams.target