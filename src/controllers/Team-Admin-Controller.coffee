angular.module('MM_Graph')
  .controller 'TeamAdminController', ($scope,  MM_API, Team_Data, $routeParams)->

    $scope.project = $routeParams.project  || Team_Data.project  # todo: should only be using Team_Data here
    $scope.team    = $routeParams.team     || Team_Data.team


    $scope.delete_Team = ->
      $scope.status = "deleting team"
      MM_API.team_Delete $scope.project, $scope.team, (response)->
        $scope.status = response

    $scope.delete_Button_Message = "Delete team #{$scope.team}"

#    using Team_Data, ->
#      @.subscribe $scope, =>                  # register to receive notification when data is available
#
#      @.notify()





