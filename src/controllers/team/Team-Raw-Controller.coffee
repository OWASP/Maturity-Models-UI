

angular.module('MM_Graph')
  .controller 'TeamRawController', ($scope, $routeParams,  team_Mappings)->
    #project = $routeParams.project
    #team    = $routeParams.team

    using team_Mappings, ->
      @.load_Data =>
        $scope.project    = @.project()
        $scope.team       = @.team()
        $scope.raw_Data   = @.team_Data.data
        $scope.data       = JSON.stringify(@.team_Data.data  , null, 4)
        $scope.activities = @.team_Raw_Map_Activities(@.team_Data.data, @.team_Data.schema)

#    if project and team
#      $scope.project = project
#      $scope.team    = team
#      API.team_Get project, team, (data)->
#        API.project_Schema project, (schema)->
#          $scope.raw_Data = data
#          $scope.data     = JSON.stringify(data  , null, 4)
#          $scope.map_Activities data, schema
