angular.module('MM_Graph')
  .controller 'ObservedController', ($scope, $routeParams, MM_API)->
    project = $routeParams.project


    $scope.map_Domains = (schema)->
      if schema
        domains     = {}
        for domain_Name,domain of schema.domains
          domains[domain_Name] = []
          for practice_Name in domain.practices
            domains[domain_Name] = domains[domain_Name].concat schema.practices[practice_Name].activities

        $scope.domains   = domains

    if project
      MM_API.project_Schema project, (schema)->
        $scope.map_Domains schema
        #console.log schema


        MM_API.project_Activities project, (data)->
          $scope.project_Activities = data
          #console.log $scope.activities
