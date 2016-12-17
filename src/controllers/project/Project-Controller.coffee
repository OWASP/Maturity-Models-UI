angular.module('MM_Graph')
  .controller 'ProjectController', ($scope, $routeParams, API, project_Data)->
    project_Data.load_Data ->
      $scope.project = project_Data.project
      $scope.teams = project_Data.teams