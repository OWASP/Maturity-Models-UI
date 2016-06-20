angular.module('MM_Graph')
  .controller 'ProjectSchemaController', ($scope, $routeParams, MM_Graph_API)->

    project = $routeParams.project
    level   = $routeParams.level

    if project
      $scope.project = project
      $scope.level   = level
      MM_Graph_API.project_Schema project, (data)->
        count   = 1
        items = {}
        for key,value of data
          if (not level) or value.level is level
            value.index = count++
            items[key] = value

        $scope.total = count - 1
        $scope.items = items 
