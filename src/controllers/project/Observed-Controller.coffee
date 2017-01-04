angular.module('MM_Graph')
  .controller 'ObservedController', ($scope, $routeParams, project_Data, observed)->

    level   = $routeParams.level || null

    $scope.key = $routeParams.key   || null

    $scope.current_Level = ()->
      level

    $scope.page_Link = ()->
      return "view/project/#{$scope.project}/observed"

    $scope.show_Activity = (activity)->
      return true if not $routeParams.level
      return activity?.level is $routeParams.level

    $scope.team_Table_Link = (team)->
      return "view/#{$scope.project}/#{team}/table"

    using project_Data, ->
      @.load_Data =>
        $scope.project    = @.project
        using observed.map_Data(), ->
          $scope.observed    = @.observed
          $scope.activities  = @.activities
          $scope.activity    = @.activity_By_Key($scope.key)
          window.scope = $scope