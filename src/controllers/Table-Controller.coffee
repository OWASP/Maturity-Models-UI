angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_Graph_API)->
    project = $routeParams.project
    team    = $routeParams.team
    if project and team
      $scope.project = project
      $scope.team    = team
      MM_Graph_API.view_Table project, team, (data)->
        $scope.table = data