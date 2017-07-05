angular.module('MM_Graph')
  .controller 'TeamAdminController', ($scope, $location,  API, team_Data)->

#    $scope.project = $routeParams.project  || team_Data.project  # todo: should only be using Team_Data here
#    $scope.team    = $routeParams.team     || team_Data.team
    $scope.deleteStatus  = ""
    $scope.renameStatus  = ""

    $scope.delete_Team = ->
      $scope.deleteStatus = "deleting team"
      API.team_Delete team_Data.project, team_Data.team, (response)->
        $scope.deleteStatus = response

    $scope.rename_Team = (newTeamName) ->
      API.team_Rename $scope.project, $scope.team, newTeamName, (response)->
        if response
          $scope.renameStatus = 'Team renamed, redirecting...'
          $location.path($location.path().replace(team_Data.team, newTeamName))
        else
          $scope.renameStatus = 'Team rename failed. Check that team name is not already in use.'

    team_Data.load_Data ->
      #$scope.project = team_Data.project
      #$scope.team    = team_Data.team
      $scope.delete_Button_Message = "Delete team #{team_Data.team}"
      $scope.rename_Button_Message = "Rename team #{team_Data.team}"

#    using Team_Data, ->
#      @.subscribe $scope, =>                  # register to receive notification when data is available
#
#      @.notify()





