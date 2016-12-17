angular.module('MM_Graph')
  .controller 'ObservedController', ($scope, $routeParams, project_Data, observed)->

    level   = $routeParams.level || null

    $scope.current_Level = ()->
      level

#    $scope.map_Domains = (schema)->
#      if schema
#        domains     = {}
#        for domain_Name,domain of schema.domains
#          domains[domain_Name] = []
#          for practice_Name in domain.practices
#            domains[domain_Name] = domains[domain_Name].concat schema.practices[practice_Name].activities
#
#        $scope.domains   = domains

#    $scope.map_Data = ()->
#      index = 0
#      for domain,activities of $scope.domains
#        $scope.domains[domain] =
#          title: domain,
#          index: index++,
#          activities: activities
#
#      for activity, activities of $scope.project_Activities
#          schema_Activity = $scope.schema.activities[activity]
#          if (not level) or schema_Activity?.level is level
#            $scope.project_Activities[activity] =
#              title: activity
#              level: schema_Activity?.level
#              name : schema_Activity?.name
#              activities: activities
#              observed: activities['Yes']?.length ? 0


    using project_Data, ->
      @.load_Data =>
        $scope.project            = @.project
        $scope.schema             = @.schema
        $scope.project_Activities = @.activities
        $scope.domains            = observed.map_Domains()
        $scope.observed           = observed.map_Observed()
        $scope.observed_By_Id     = observed.get_Observed_By_Id()

        #$scope.map_Domains @.schema
        #$scope.map_Data()

#    return
#    if project
#      $scope.project = project
#
#      using API,->
#        @.project_Schema project, (schema)=>
#          $scope.schema = schema
#          $scope.map_Domains schema
#          @.project_Activities project, (data)->
#            $scope.project_Activities = data
#            $scope.map_Data()
