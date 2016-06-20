angular.module('MM_Graph')
  .controller 'ProjectController', ($scope, $routeParams, MM_Graph_API)->
  
    target = $routeParams.target    
    if target
      $scope.target = target
      MM_Graph_API.project_Get target, (data)->
        $scope.teams = data      