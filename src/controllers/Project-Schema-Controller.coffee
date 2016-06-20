angular.module('MM_Graph')
  .controller 'ProjectSchemaController', ($scope, $routeParams, MM_Graph_API)->

    project = $routeParams.project
    level   = $routeParams.level
    if project
      $scope.project = project
      $scope.level   = level
      MM_Graph_API.project_Schema project, (data)->
        $scope.schema = data