angular.module('MM_Graph')
  .controller 'ProjectController', ($scope, $routeParams, API)->
    project = $routeParams.project
    if project
      $scope.project = project
      API.project_Get project, (data)->
        $scope.teams = data