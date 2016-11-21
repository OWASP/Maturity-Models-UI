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

    $scope.set_Colors = ()->
      colors = ['#8FC740' ,'#E17626' , '#1E609D' ,'#51803C']
      index = 0
      for domain,activities of $scope.domains
        $scope.domains[domain] = title: domain, index: index++, color: colors.shift(), activities: activities


    if project
      $scope.project = project

      using MM_API,->
        @.project_Schema project, (schema)=>
          $scope.map_Domains schema
          @.project_Activities project, (data)->
            $scope.project_Activities = data
            $scope.set_Colors()
