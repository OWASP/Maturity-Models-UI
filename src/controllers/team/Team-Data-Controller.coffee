angular.module('MM_Graph')
  .controller 'TeamDataController', ($scope, $rootScope, $timeout, $routeParams, ui_Status)->


    $scope.ui_Status = ui_Status

    $scope.current_Filter = ->
      return $routeParams.filter