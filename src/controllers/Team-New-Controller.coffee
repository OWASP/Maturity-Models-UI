angular.module('MM_Graph')
  .controller 'TeamNewController', ($scope, $routeParams,  MM_API)->
    project = $routeParams.project
    
    if project
      $scope.status = 'creating new team'
      
#      $scope.project = project
#      $scope.team    = team
#      MM_API.file_Get project, team, (data)->
#        $scope.raw_Data = data
#        $scope.data     = JSON.stringify(data, null, 4)
