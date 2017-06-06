angular.module('MM_Graph')
  .controller 'TeamEditController', ($scope, $routeParams,  team_Mappings)->
    $scope.messageClass = 'secondary'

    using team_Mappings, ->
      @.load_Data =>
        @.team_Edit_Map_Domains()

        $scope.team_Data = @.team_Data
        $scope.domains   = @.domains
        $scope.data      = @.team_Data.data