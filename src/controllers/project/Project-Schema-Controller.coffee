  angular.module('MM_Graph')
  .controller 'ProjectSchemaController', ($scope, $routeParams, API, project_Data)->

    $scope.create_Table_Rows = (data)->
      rows = []
      for domain_Name, domain of data?.domains
        practices   = domain.practices
        domain_Data = value: domain_Name , rowspan:0, id: domain_Name
        domain_Row  = [ domain_Data]

        for practice_Name in practices
          practice           = data.practices[practice_Name]
          activities           = practice.activities
          domain_Data.rowspan += activities.size()
          practice_Row         = domain_Row
          practice_Row.push    value: practice_Name, rowspan: activities.size() , id: practice.key

          for key in activities
            row       = practice_Row
            activity  = data.activities[key]
            if activity
              row.push value : key , id :key
              row.push value : activity.level
              row.push value : activity.name

              rows.push row
            domain_Row   = []
            practice_Row = []
      return rows

    using project_Data, ->
      @.load_Data =>
        $scope.project = @.project
        $scope.level   = $routeParams.level || null
        $scope.rows    = $scope.create_Table_Rows @.schema