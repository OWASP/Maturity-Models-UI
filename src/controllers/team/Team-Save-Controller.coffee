angular.module('MM_Graph')
  .controller 'TeamSaveController', ($scope, team_Data)->


    $scope.save_Data = ()->
      $scope.status = 'saving data ....'
      team_Data.save (result)->
        if result.error
          $scope.messageClass = 'alert'
          $scope.status = result.error
        else
          $scope.messageClass = 'success'
          $scope.status = result.status


    $scope.messageClass = 'secondary'
    $scope.status       = 'loading team data'

    team_Data.load_Data =>
      if team_Data.data
        $scope.metadata = team_Data.data.metadata
        $scope.status   = 'data loaded'


#    using Team_Data, ->
#      @.subscribe $scope, =>                  # register to receive notification when data is available
#        $scope.load_Data()
#      @.notify()                              # trigger notification if it already exists