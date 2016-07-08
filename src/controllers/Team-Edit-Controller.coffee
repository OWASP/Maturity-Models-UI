angular.module('MM_Graph')
  .controller 'TeamEditController', ($scope, $routeParams,  MM_Graph_API)->
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

    $scope.map_Domains = (schema, data)->
      domains = {}
      for domain_Name,domain of schema.domains
        values = {}
        for practice_Name in domain.practices
          for activity_Key in schema.practices[practice_Name].activities            
            values[activity_Key] = data.activities[activity_Key]
        domains[domain_Name] = values
      return domains
      
    if project and team
      $scope.status = 'loading team data'
      $scope.project = project
      $scope.team    = team
      MM_Graph_API.project_Schema project, (schema)->
        $scope.schema = schema
        MM_Graph_API.file_Get project, team, (data)->
          $scope.status       = 'data loaded'
          $scope.data         = data
          $scope.metadata     = data.metadata
          $scope.domains      = $scope.map_Domains schema , data
    else
      $scope.status = 'No team provided'

