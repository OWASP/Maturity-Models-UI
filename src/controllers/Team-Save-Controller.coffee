angular.module('MM_Graph')
  .controller 'TeamSaveController', ($scope, Team_Data)->


    $scope.load_Data = ->
      if Team_Data.data
        $scope.metadata = Team_Data.data.metadata
        $scope.status   = 'data loaded'


    $scope.save_Data = ()->
      $scope.status = 'saving data ....'
      Team_Data.save (result)->

#      MM_API.file_Save project,team , $scope.data, (result)->
        if result.error
          $scope.messageClass = 'alert'
          $scope.status = result.error
        else
          $scope.messageClass = 'success'
          $scope.status = result.status


    $scope.messageClass = 'secondary'
    $scope.status       = 'loading team data'

    using Team_Data, ->
      @.subscribe $scope, =>                  # register to receive notification when data is available
        $scope.load_Data()
      @.notify()                              # trigger notification if it already exists