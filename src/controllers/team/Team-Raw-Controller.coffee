angular.module('MM_Graph')
  .controller 'TeamRawController', ($scope, $routeParams,  API)->
    project = $routeParams.project
    team    = $routeParams.team  


    $scope.map_Activities = (data, schema)->
      mappings = []
      for key,value of data?.activities
        activity_Schema = schema?.activities[key]
        mappings.push
          id   : key
          name : activity_Schema?.name
          value: value

      $scope.activities = mappings

    if project and team      
      $scope.project = project
      $scope.team    = team
      API.team_Get project, team, (data)->
        API.project_Schema project, (schema)->
          $scope.raw_Data = data
          $scope.data     = JSON.stringify(data  , null, 4)
          $scope.map_Activities data, schema
