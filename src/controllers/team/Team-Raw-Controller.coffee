

angular.module('MM_Graph')
  .controller 'TeamRawController', ($scope, $routeParams,  API)->
    project = $routeParams.project
    team    = $routeParams.team

    pad = (value, length) ->
      if value
        padding = length - value.length + 1
        if (padding >= 1)
          value + Array(padding + 1).join(' ')
        else
          value

    $scope.map_Activities_For_Level = (data, schema, level)->
      mapping = "Level #{level}\n" + Array(124).join('-') + '\n'
      for key,value of data?.activities
        activity_Schema = schema?.activities[key]
        if activity_Schema?.level is level
          mapping += "#{pad(key,7)} | #{pad(activity_Schema?.name, 102)} | #{value.value} \n"
          #mapping += "#{pad(key,7)} | #{pad(value.value,4) } | #{pad(activity_Schema?.name, 102)} \n"   # see https://github.com/OWASP/Maturity-Models/issues/202#issuecomment-267292073
      return mapping

    $scope.map_Activities = (data, schema)->

      $scope.activities = $scope.map_Activities_For_Level(data, schema, '1') + '\n' +
                          $scope.map_Activities_For_Level(data, schema, '2') + '\n' +
                          $scope.map_Activities_For_Level(data, schema, '3')


    if project and team      
      $scope.project = project
      $scope.team    = team
      API.team_Get project, team, (data)->
        API.project_Schema project, (schema)->
          $scope.raw_Data = data
          $scope.data     = JSON.stringify(data  , null, 4)
          $scope.map_Activities data, schema
