

angular.module('MM_Graph')
  .controller 'TeamRawController', ($scope, $routeParams,  API)->
    project = $routeParams.project
    team    = $routeParams.team

    pad = (value, length) ->
      if value
        padding = length - value.length + 1
        if (padding > 1)
          value + Array(padding + 1).join(' ')
#        else
#          value

    $scope.map_Activities = (data, schema)->
      mapping = ''
      for key,value of data?.activities
        activity_Schema = schema?.activities[key]
        mapping += "#{pad(key,10)} | #{pad(activity_Schema?.name, 92)} | #{value.value} \n"

      $scope.activities = mapping

    if project and team      
      $scope.project = project
      $scope.team    = team
      API.team_Get project, team, (data)->
        API.project_Schema project, (schema)->
          $scope.raw_Data = data
          $scope.data     = JSON.stringify(data  , null, 4)
          $scope.map_Activities data, schema
