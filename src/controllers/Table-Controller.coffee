angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_Graph_API)->
    project = $routeParams.project
    team    = $routeParams.team
    level   = $scope.level?.toString()

    $scope.map_Rows = ()->

      data    = $scope.data
      schema  = $scope.schema
      mappings = []
#      yeses    = 0

      for domain, activity of data?.activities
        for key,value of activity
          row = [domain]
          if schema[key]
            cell_Activity_Id = key
            cell_Activity    = schema[key].activity || ''
            cell_Level       = schema[key].level    || ''
            cell_Practice    = schema[key].practice || ''
            if (not level) or cell_Level is level
              row.push cell_Practice, cell_Activity_Id, cell_Level , cell_Activity
              switch value
                when 'Yes'
                  row.push true , false, false, false
#                  yeses += 1
                when 'No'    
                  row.push false, true , false, false
                when 'NA'
                  row.push false, false, true , false
#                  yeses += 1
                when 'Maybe' 
                  row.push false, false, false, true
#                  yeses += 0.2
              row.push ''  # proof value
              mappings.push row
 #     console.log mappings.size(), yeses
 #     $scope.score = Math.round((yeses / mappings.size()) * 100)
      mappings
    
    if project and team
      $scope.project = project
      $scope.team    = team
      MM_Graph_API.project_Schema project, (schema)->
        $scope.schema = schema
        MM_Graph_API.data_Score project, team, (scores)->
          $scope.scores = scores
          $scope.score = scores["level_#{level}"]?.percentage

          MM_Graph_API.file_Get project, team, (data)->
            $scope.data = data
            $scope.rows = $scope.map_Rows()
            $scope.show = true
            #console.log $scope.rows
            #$scope.rows = $scope.map_Rows(data, schema)
