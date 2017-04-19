describe 'controllers | Team-Admin-Controller', ->
  $scope      = null
  location    = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, $routeParams, $location)->
      $scope      = $rootScope.$new()
      location = $location
      $routeParams.project = project
      $routeParams.team    = team
      $controller('TeamAdminController', { $scope: $scope })
      $httpBackend.flush()

  it 'check $scope values',->
    using $scope, ->
      (typeof @.delete_Team).assert_Is 'function'
      @.delete_Button_Message.assert_Is 'Delete team team-A'
      @.rename_Button_Message.assert_Is 'Rename team team-A'

  it '$scope.delete_Team', ->
    using $scope, ->
      @.deleteStatus.assert_Is ""
      @.delete_Team()
      @.deleteStatus.assert_Is 'deleting team'
      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/delete/#{team}").respond { status: 'deleted'}
        $httpBackend.flush()
      @.deleteStatus.assert_Is { status: 'deleted'}

  it '$scope.rename_Team success', ->
    using $scope, ->
      @.project = project
      @.team = team
      newTeamName = 'super-team'
      location.path("/view/ASVS/#{team}/admin")
      @.$apply()
      @.rename_Team(newTeamName)
      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/rename/#{team}/#{newTeamName}").respond true
        $httpBackend.flush()
      @.renameStatus.contains 'renamed'
      location.path().assert_Is "/view/ASVS/#{newTeamName}/admin"

  it '$scope.rename_Team fail', ->
    using $scope, ->
      @.project = project
      @.team = team
      newTeamName = 'super-team'
      originalLocation = "/view/ASVS/#{team}/admin"
      location.path(originalLocation)
      @.rename_Team(newTeamName)
      inject ($httpBackend)->
        $httpBackend.expectGET("/api/v1/team/#{project}/rename/#{team}/#{newTeamName}").respond false
        $httpBackend.flush()
      @.renameStatus.contains 'failed'
      location.path().assert_Is originalLocation




