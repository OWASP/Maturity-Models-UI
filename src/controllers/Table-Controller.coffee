angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, MM_Graph_API)->
    project = $routeParams.project
    team    = $routeParams.team
    level   = $scope.level?.toString()

    $scope.map_Rows = ()->
      data    = $scope.data
      schema  = $scope.schema
      mappings = []           
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
                when 'Yes'   then row.push true , false, false, false
                when 'No'    then row.push false, true , false, false
                when 'NA'    then row.push false, false, true , false
                when 'Maybe' then row.push false, false, false, true
              row.push ''  # proof value
              mappings.push row


      mappings
    
    if project and team
      $scope.project = project
      $scope.team    = team
      MM_Graph_API.project_Schema project, (schema)->
        $scope.schema = schema      
        MM_Graph_API.file_Get project, team, (data)->
          $scope.data = data
          $scope.rows = $scope.map_Rows()
          $scope.show = true
          #console.log $scope.rows
          #$scope.rows = $scope.map_Rows(data, schema)
