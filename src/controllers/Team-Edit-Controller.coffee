angular.module('MM_Graph')
  .controller 'TeamEditController', ($scope, $routeParams,  MM_API)->
    project = $routeParams.project
    team    = $routeParams.team  
    $scope.messageClass = 'secondary'
#    $scope.save_Data = ()->
#      #$scope.status = 'saving data ....'
#      MM_API.file_Save project,team , $scope.data, (result)->
#        if result.error
#          $scope.messageClass = 'alert'
#          $scope.status = result.error
#        else
#          $scope.messageClass = 'success'
#          $scope.status = result.status

    $scope.map_Domains = (schema, data)->
      domains = {}
      for domain_Name,domain of schema.domains
        domains[domain_Name] = []
        for practice_Name in domain.practices
          domains[domain_Name] = domains[domain_Name].concat schema.practices[practice_Name].activities
      return domains
      
    if project and team
      $scope.status = 'loading team data'
      $scope.project = project
      $scope.team    = team
      
      MM_API.project_Schema project, (schema)->
        $scope.schema = schema
        MM_API.team_Get project, team, (data)->
          data.metadata      ?= { team: ''}                    #todo: set default value. This should be done on the backend
          $scope.status       = 'data loaded'
          $scope.data         = data
          $scope.metadata     = data.metadata
          $scope.domains      = $scope.map_Domains schema , data
    else
      $scope.status = 'No team provided'

