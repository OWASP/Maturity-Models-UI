describe 'controllers | Team-New-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope      = $rootScope.$new()
      routeParams = project : project
      $controller('TeamNewController', { $scope: $scope, $routeParams : routeParams })
      #$httpBackend.flush()

  it 'check $scope values',->
    using $scope, ->
      @.project.assert_Is project
      inject ($httpBackend, $location)=>
        @.status .assert_Is 'Creating new team'
        $httpBackend.flush()
        @.data  .assert_Is { status: 'Ok', team_Name: 'new-team-myxxk' }
        @.status.assert_Is 'Team created ok, redirecting...'
        $location.url().assert_Is "/view/#{project}/#{@.data.team_Name}/table"



