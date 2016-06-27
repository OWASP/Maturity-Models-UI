angular.module('MM_Graph')
  .controller 'EditDataController', ($scope, $routeParams,  MM_Graph_API)->
    project = $routeParams.project
    team    = $routeParams.team  
    $scope.messageClass = 'secondary'
    $scope.save_Data = ()->
      #$scope.status = 'saving data ....'
      MM_Graph_API.file_Save project,team , $scope.data, (result)->
        if result.error
          $scope.messageClass = 'alert'
          $scope.status = result.error
        else
          $scope.messageClass = 'success'
          $scope.status = result.status


    if project and team
      $scope.status = 'loading team data'
      $scope.project = project
      $scope.team    = team
      MM_Graph_API.file_Get project, team, (data)->
        $scope.status       = 'data loaded'
        $scope.data_Raw     = JSON.stringify(data, null, 4)
        $scope.data         = data
        $scope.metadata     = data.metadata
        $scope.governance   = $scope.data?.activities?.Governance
        $scope.intelligence = $scope.data?.activities?.Intelligence
        $scope.ssdl         = $scope.data?.activities?.SSDL
        $scope.deployment   = $scope.data?.activities?.Deployment

    else
      $scope.status = 'No team provided'

