angular.module('MM_Graph')
  .controller 'TeamSaveController', ($scope, $rootScope, keyboard, team_Data)->

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

    $scope.$on 'keyup_CtrS', (event,args)->                 # receive event when Ctrl+S was pressed
      $scope.save_Data()                                    # trigger save data
      args.preventDefault()                                 # prevent OS/browser from showing the default save dialog box

    $rootScope.$on 'onChange', ()->
      $scope.status = 'unsaved data'
      $scope.messageClass = 'warning'