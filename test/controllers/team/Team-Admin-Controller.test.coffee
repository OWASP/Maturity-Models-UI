describe 'controllers | Team-Delete-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, $routeParams)->
      $scope      = $rootScope.$new()
      $routeParams.project = project
      $routeParams.team    = team
      #$controller('TeamDataController', { $scope: $scope })

      $controller('TeamAdminController', { $scope: $scope })
      $httpBackend.flush()

  it 'check $scope values',->
    using $scope, ->
      (typeof @.delete_Team).assert_Is 'function'
      @.delete_Button_Message.assert_Is 'Delete team team-A'

  it '$scope.delete_Team', ->
    using $scope, ->
      @.status.assert_Is ""
      @.delete_Team()
      @.status.assert_Is 'deleting team'
      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/delete/#{team}").respond { status: 'deleted'}
        $httpBackend.flush()
      @.status.assert_Is { status: 'deleted'}




