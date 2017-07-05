describe 'controllers | Table-Controller', ->
  $scope      = null
  $attrs      = {}                                              # need to provide this as a provider of the  $controller(...) will throw an missing $attrsProvider error. It is probably due to the fact that this provider is not currently mocked
  project     = 'bsimm'
  team        = 'team-A'

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend, $routeParams)->
      $scope = $rootScope.$new()
      $routeParams.project = project
      $routeParams.team    = team
      $attrs.level         = '1'
      $controller('TableController', { $scope: $scope , $attrs})
      $httpBackend.flush()


  it 'check $scope values', ->
    $scope.data.keys().assert_Is [ 'metadata', 'activities' ]
    $scope.rows.size().assert_Is 39
    $scope.score      .assert_Is '64%'
    $scope.show       .assert_Is_True()



  #it '$controller, $scope.map_Rows',->
  it 'should have all data when controller is loaded', ->
    using $scope.rows, ->
      @[0].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.1', '1', 'Publish process (roles, responsibilities, plan), evolve as necessary', true , false, false, false] # Yes
      @[1].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.2', '1', 'Create evangelism role and perform internal marketing'               , false, true , false ,false] # NA
      @[2].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.3', '1', 'Educate executives'                                                  , false, false, true , false] # Maybe
      @[3].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.4', '1', 'Identify gate locations, gather necessary artifacts'                 , false, false, false, true ] # No
      @.size().assert_Is 39

