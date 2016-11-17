angular.module('MM_Graph')
  .controller 'TeamEditController', ($scope, $routeParams,  Team_Data)->
    $scope.messageClass = 'secondary'

    $scope.map_Domains = ()->
      if Team_Data.schema
        schema      = Team_Data.schema
        domains     = {}
        for domain_Name,domain of schema.domains
          domains[domain_Name] = []
          for practice_Name in domain.practices
            domains[domain_Name] = domains[domain_Name].concat schema.practices[practice_Name].activities

        $scope.team_Data = Team_Data
        $scope.domains   = domains
        $scope.data      = Team_Data.data
        #$scope.data      = Team_Data.data

        Team_Data.data.metadata      ?= { team: ''} # todo: set default value. This should be done on the backend

    using Team_Data, ->
      @.subscribe $scope, =>                  # register to receive notification when data is available
        $scope.map_Domains()
      @.notify()

