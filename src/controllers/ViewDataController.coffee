angular.module('MM_Graph')
  .controller 'ViewDataController', ($scope, $routeParams, MM_Graph_API)->

    project = $routeParams.project
    team    = $routeParams.team
    
    if project and team
      $scope.status = 'loading team data'
      $scope.target = target
      MM_Graph_API.file_Get project, team, (data)->
        $scope.status = 'data loaded'
        $scope.data   = JSON.stringify(data, null, 4)
        console.log JSON.stringify(data, null, 2)
    else
      $scope.status = 'No team provided'


