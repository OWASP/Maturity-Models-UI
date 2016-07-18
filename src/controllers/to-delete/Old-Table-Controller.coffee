angular.module('MM_Graph')
  .controller 'OldTableController', ($scope, $routeParams, MM_API)->
    project = $routeParams.project
    team    = $routeParams.team

    if project and team
      $scope.project = project
      $scope.team    = team
      MM_API.view_Table project, team, (data)->
        $scope.table = data

