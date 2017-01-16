angular.module('MM_Graph')
  .controller 'TableController', ($scope, $routeParams, team_Mappings, $attrs)->

    level   = $attrs.level?.toString()
    filter  = $routeParams.filter || $attrs.filter      # get value from url params or from element that consumed this controller

    $scope.observed_Link = ()->
      return "view/project/#{$scope.project}/observed"

    using team_Mappings, ->
      @.load_Data =>
        @.team_Table_Map_Rows level, filter
        $scope.project = @.project()
        $scope.data    = @.team_Data.data                                     # used to sync values to real objects (so that it can be saved)
        $scope.rows    = @.mappings
        $scope.score   = @.team_Data.scores["level_#{level}"]?.percentage
        $scope.show    = true


    $scope.onChanged = (target)->
      $scope.$emit 'onChange', target