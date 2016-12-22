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
      $controller('TableController', { $scope: $scope , $attrs})
      $httpBackend.flush()



  #it '$controller, $scope.map_Rows',->
  it 'should have all data when controller is loaded', ->
    using $scope.rows, ->
      @[0].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.1', '1', 'Publish process (roles, responsibilities, plan), evolve as necessary', true , false, false, false, ''] # Yes
      @[1].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.2', '1', 'Create evangelism role and perform internal marketing'               , false, true , false ,false, ''] # NA
      @[2].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.3', '1', 'Educate executives'                                                  , false, false, true , false, ''] # Maybe
      @[3].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.4', '1', 'Identify gate locations, gather necessary artifacts'                 , false, false, false, true , ''] # No
      @.size().assert_Is 112

  # to be moved to a team_Service test
  xit 'should filter rows based on filter value', ->
    inject ($controller, $routeParams, $httpBackend)->
      check_Filter = (filter, size)->
          $routeParams.filter = filter
          $scope.rows.size().assert_Is size

      check_Filter ''      , 112
      check_Filter 'Yes'   , 29
      check_Filter 'No'    , 56
      check_Filter 'NA'    , 4
      check_Filter 'Maybe' , 23
      check_Filter 'Yes,No', 85
      check_Filter 'Yes,NA', 33
      check_Filter 'No,NA' , 60

