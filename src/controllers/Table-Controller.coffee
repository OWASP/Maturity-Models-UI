angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_API)->
    #project = $routeParams.project
    #team    = $routeParams.team
    level   = $scope.level?.toString()

    $scope.map_Rows = ()->

      data       = $scope.data
      schema     = $scope.schema
      activities = schema.activities
      mappings = []

      #console.log schema

      for domain_Name, domain of schema.domains
        for practice_Name in domain.practices
          practice = schema.practices[practice_Name]
          for activity_Key in practice.activities
            activity = schema.activities[activity_Key]
            if activity
              if (not level) or activity.level is level
                row = [domain_Name, practice_Name, activity_Key, activity.level, activity.name]

                value = data.activities?[activity_Key]

                switch value
                  when 'Yes'   then row.push true , false, false, false
                  when 'No'    then row.push false, true , false, false
                  when 'NA'    then row.push false, false, true , false
                  when 'Maybe' then row.push false, false, false, true

                row.push ''  # proof value
                mappings.push row

      return mappings

    using $scope, ->
      if @.scores and @.data and @.schema
        @.rows = @.map_Rows()
        @.score = @.scores["level_#{level}"]?.percentage
        #$scope.show = true

    if false and project and team
      #$scope.project = project
      #$scope.team    = team
      MM_API.project_Schema project, (schema)->
        $scope.schema = schema
        MM_API.data_Score project, team, (scores)->
          $scope.scores = scores
          $scope.score = scores["level_#{level}"]?.percentage

          MM_API.team_Get project, team, (data)->
            $scope.data = data
            $scope.rows = $scope.map_Rows()
            $scope.show = true
