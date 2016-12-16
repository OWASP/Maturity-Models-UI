angular.module('MM_Graph')
  .controller 'TeamDataController', ($scope, $routeParams, Team_Data)->

    using Team_Data, ->
      @.load_From_Cache $routeParams.project, $routeParams.team

    $scope.current_Filter = ->
      return $routeParams.filter

