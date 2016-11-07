angular.module('MM_Graph')
  .controller 'TeamMetadataController', ($scope, $routeParams,  Team_Data)->
    project = $routeParams.project
    team    = $routeParams.team  
    
    $scope.load_Data = =>
      $scope.project = project
      $scope.team    = team
      $scope.data    = Team_Data.data

    using Team_Data, ->
      @.subscribe $scope, =>                  # register to receive notification when data is available
        $scope.load_Data()
      @.notify()                              # trigger notification if it already exists
