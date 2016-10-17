describe 'controllers | Table-Controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'

  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope, $httpBackend)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('TeamDataController', { $scope: $scope, $routeParams : routeParams })   # load data via Team-Data-Controller
      $httpBackend.flush()


  #it '$controller, $scope.map_Rows',->
  it 'should have all data when controller is loaded', ->
    inject ($controller)->
      $controller('TableController', { $scope: $scope, $routeParams : routeParams })
      using $scope.rows, ->
        @[0].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.1', '1', 'Publish process (roles, responsibilities, plan), evolve as necessary', true , false, false, false, ''] # Yes
        @[1].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.2', '1', 'Create evangelism role and perform internal marketing'               , false, true , false ,false, ''] # NA
        @[2].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.3', '1', 'Educate executives'                                                  , false, false, true , false, ''] # Maybe
        @[3].assert_Is [ 'Governance', 'Strategy & Metrics', 'SM.1.4', '1', 'Identify gate locations, gather necessary artifacts'                 , false, false, false, true , ''] # No
        @.size().assert_Is 112


  it 'should filter rows based on filter value', ->
    inject ($controller)->
      check_Filter = (filter, size)->
          routeParams.filter = filter
          $controller('TableController', { $scope: $scope, $routeParams : routeParams })
          $scope.rows.size().assert_Is size

      check_Filter ''      , 112
      check_Filter 'Yes'   , 29
      check_Filter 'No'    , 8
      check_Filter 'NA'    , 4
      check_Filter 'Maybe' , 23
      check_Filter 'Yes,No', 37
      check_Filter 'Yes,NA', 33
      check_Filter 'No,NA' , 12

