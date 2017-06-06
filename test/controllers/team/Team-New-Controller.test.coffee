describe 'controllers | Team-New-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope      = $rootScope.$new()
      routeParams = project : project
      $controller('TeamNewController', { $scope: $scope, $routeParams : routeParams })

  it 'check $scope values',->
    using $scope, ->
      @.project.assert_Is project
      inject ($httpBackend, $location)=>
        @.status .assert_Is 'Creating new team'
        $httpBackend.flush()

        @.data.status    .assert_Is 'Ok'
        @.data.team_Name .assert_Contains 'team-'
        @.status.assert_Is 'Team created ok, redirecting...'
        $location.url().assert_Is "/view/#{project}/#{@.data.team_Name}/radar"

  it '$scope.on_New_Team', ->
    using $scope, ->
      @.on_New_Team {}
      @.data.assert_Is {}
      @.status.assert_Is 'Error: failed to create team'


