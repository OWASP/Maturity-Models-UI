angular.module('MM_Graph')
  .controller 'TeamNewController', ($scope, $routeParams,  $location, MM_API)->
    project = $routeParams.project
    
    if project
      $scope.project = project
      $scope.status  = 'Creating new team'
      MM_API.team_New project, (data)->
        $scope.data   = data        
        if data.status is 'Ok'        
          $scope.status = 'Team created ok, redirecting...'
          $location.url("/view/#{project}/#{data.team_Name}/table")
        else
          $scope.status = 'Error: failed to create team'
