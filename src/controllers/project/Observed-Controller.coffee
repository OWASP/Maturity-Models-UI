angular.module('MM_Graph')
  .controller 'ObservedController', ($scope, $routeParams, project_Data, observed)->

    level   = $routeParams.level || null

    $scope.current_Level = ()->
      level

    using project_Data, ->
      @.load_Data =>
        $scope.project    = @.project
        using observed.map_Data(), ->
          $scope.observed = @.observed
          $scope.observed_By_Id = @.observed_By_Id

    $scope.show_Activity = (activity)->
      return true if not $routeParams.level
      return activity?.level is $routeParams.level