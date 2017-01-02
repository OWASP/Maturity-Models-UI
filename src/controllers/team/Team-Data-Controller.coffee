angular.module('MM_Graph')
  .controller 'TeamDataController', ($scope, $routeParams)->

    $scope.current_Filter = ->
      return $routeParams.filter

