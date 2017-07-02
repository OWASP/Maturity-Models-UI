angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, team_Mappings, $attrs, ui_Status)->

    level   = $attrs.level?.toString()
    filter  = $routeParams.filter || $attrs.filter      # get value from url params or from element that consumed this controller

    $scope.show_Fields = ui_Status.team_Table_Fields

    $scope.observed_Link = ()->
      return "view/project/#{$scope.project}/observed"


    $scope.map_Descriptions = ()->

      descriptions = {}
      for key, activity of $scope.schema_Details.activities
        descriptions[key] =
          description      : activity.description
          hide_Description : true
          answers          : activity.answers
      descriptions



    using team_Mappings, ->
      @.load_Data =>
        @.team_Table_Map_Rows level, filter
        $scope.project        = @.project()
        $scope.data           = @.team_Data.data                                     # used to sync values to real objects (so that it can be saved)
        $scope.rows           = @.mappings
        $scope.score          = @.team_Data.scores["level_#{level}"]?.percentage
        $scope.show           = true
        $scope.schema_Details = @.team_Data.schema_Details

        $scope.descriptions   = $scope.map_Descriptions()



    $scope.onChanged = (target)->
      $scope.$emit 'onChange', target