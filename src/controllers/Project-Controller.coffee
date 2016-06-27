angular.module('MM_Graph')
  .controller 'ProjectController', ($scope, $routeParams, MM_Graph_API)->

    project = $routeParams.project
    if project
      $scope.project = project
      MM_Graph_API.project_Get project, (data)->
        $scope.teams = data
        $scope.aaaa = 123123