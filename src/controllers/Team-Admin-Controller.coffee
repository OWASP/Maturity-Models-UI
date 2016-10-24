angular.module('MM_Graph')
  .controller 'TeamAdminController', ($scope, $routeParams,  MM_API)->
    project = $routeParams.project
    team    = $routeParams.team  

    $scope.delete_Team = ->
      $scope.status = "deleting team"
    $scope.status = 'you can delete team'

