angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_API)->
    project = $routeParams.project
    team    = $routeParams.team
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

          #console.log domain

#      for domain, activity of data?.activities
#        for key,value of activity
#          row = [domain]
#          if activities[key]
#            cell_Activity_Id = key
#            cell_Activity    = activities[key].name || ''
#            cell_Level       = activities[key].level    || ''
#            cell_Practice    = activities[key].practice || ''
#            if (not level) or cell_Level is level
#              row.push cell_Practice, cell_Activity_Id, cell_Level , cell_Activity
#              switch value
#                when 'Yes'   then row.push true , false, false, false
#                when 'No'    then row.push false, true , false, false
#                when 'NA'    then row.push false, false, true , false
#                when 'Maybe' then row.push false, false, false, true
#
#              row.push ''  # proof value
#              mappings.push row
# #     console.log mappings.size(), yeses
# #     $scope.score = Math.round((yeses / mappings.size()) * 100)
#      mappings
    
    if project and team
      $scope.project = project
      $scope.team    = team
      MM_API.project_Schema project, (schema)->
        $scope.schema = schema
        MM_API.data_Score project, team, (scores)->
          $scope.scores = scores
          $scope.score = scores["level_#{level}"]?.percentage

          MM_API.file_Get project, team, (data)->
            $scope.data = data
            $scope.rows = $scope.map_Rows()
            $scope.show = true
            #console.log $scope.rows
            #$scope.rows = $scope.map_Rows(data, schema)
