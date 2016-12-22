angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, team_Data, $attrs)->

    level   = $scope.level?.toString()                  # todo: this value shouldn't be set here
    filter  = $routeParams.filter || $attrs.filter      # get value from url params or from element that consumed this controller

    $scope.map_Rows = ()->
      
      data       = team_Data.data
      schema     = team_Data.schema

      return if (not data) or (not schema)
        
      mappings = []

      for domain_Name, domain of schema.domains
        for practice_Name in domain.practices
          practice = schema.practices[practice_Name]
          for activity_Key in practice.activities
            activity = schema.activities[activity_Key]
            if activity
              if (not level) or activity.level is level
                row = [domain_Name, practice_Name, activity_Key, activity.level, activity.name]
                activity_Data = data.activities?[activity_Key]
                value         = activity_Data?.value
                if filter                                         # if filter value is set
                  if (not (filter.contains value))                # and it contains the current value
                    continue

                switch value
                  when 'Yes'   then row.push true , false, false, false
                  when 'No'    then row.push false, true , false, false
                  when 'NA'    then row.push false, false, true , false
                  when 'Maybe' then row.push false, false, false, true

                row.push ''  # proof value
                mappings.push row


      $scope.data = team_Data.data                                     # used to sync values to real objects (so that it can be saved)
      $scope.rows  = mappings
      $scope.score = team_Data.scores["level_#{level}"]?.percentage
      $scope.show  = true

    using team_Data, ->
      @.load_Data =>
        $scope.map_Rows()



