angular.module('MM_Graph')
  .controller 'ProjectSchemaDetailsController', ($scope, $routeParams, API, project_Data)->

    $scope.show_Row = (level, domain)->
      if (not $scope.level) or (level is $scope.level)
        if (not $scope.domain) or (domain is $scope.domain)
          return true
      return false
      
    $scope.create_Scheme_Details_Table_Rows = (schema, schema_Details)->
      rows = []

      for domain_Name, domain of schema?.domains
        practices   = domain.practices
        for practice_Name in practices
          practice           = schema.practices[practice_Name]
          activities           = practice.activities
          for key in activities
            activity         = schema.activities[key]
            activity_Details = schema_Details.activities[key]
            if $scope.show_Row(activity.level, domain_Name)
                cells = [domain_Name, practice_Name, key, activity.level, activity.name,
                         activity_Details?.objective, activity_Details?.proof, activity_Details?.description]

                rows.push cells
      return rows

    $scope.current_Level = ()->
      return $scope.level

    $scope.current_Domain = ()->
     return $scope.domain

    $scope.page_Link = ()->
      return "view/project/#{$scope.project}/schema-details"

    $scope.observed_Link = ()->
      return "view/project/#{$scope.project}/observed"

    using project_Data, ->
      @.load_Data =>
        $scope.project        = @.project
        $scope.level          = $routeParams.level  || null
        $scope.domain         = $routeParams.domain || null
        $scope.domains        = @.schema.domains.keys()
        $scope.rows           = $scope.create_Scheme_Details_Table_Rows @.schema, @.schema_Details