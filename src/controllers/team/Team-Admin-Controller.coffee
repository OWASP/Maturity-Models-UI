angular.module('MM_Graph')
  .controller 'TeamAdminController', ($scope,  API, team_Data)->

#    $scope.project = $routeParams.project  || team_Data.project  # todo: should only be using Team_Data here
#    $scope.team    = $routeParams.team     || team_Data.team
    $scope.status  = ""

    $scope.delete_Team = ->
      $scope.status = "deleting team"
      API.team_Delete team_Data.project, team_Data.team, (response)->
        $scope.status = response

    team_Data.load_Data ->
      #$scope.project = team_Data.project
      #$scope.team    = team_Data.team
      $scope.delete_Button_Message = "Delete team #{team_Data.team}"

#    using Team_Data, ->
#      @.subscribe $scope, =>                  # register to receive notification when data is available
#
#      @.notify()





