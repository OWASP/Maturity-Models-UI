angular.module('MM_Graph')
  .controller 'TeamMetadataController', ($scope, $routeParams,  team_Data)->
    team_Data.load_Data =>
      $scope.project = team_Data.project
      $scope.team    = team_Data.team
      $scope.data    = team_Data.data

      $scope.onChanged = (target)->
        $scope.$emit 'onChange', target