describe 'controllers | Team-Delete-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope      = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TeamDataController', { $scope: $scope, $routeParams : routeParams })
      $httpBackend.flush()
      $controller('TeamAdminController', { $scope: $scope })

  it 'check $scope values',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team
      (typeof @.delete_Team).assert_Is 'function'
      @.delete_Button_Message.assert_Is 'Delete team team-A'




