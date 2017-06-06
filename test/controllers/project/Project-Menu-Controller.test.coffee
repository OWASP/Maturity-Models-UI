describe 'controllers | project | Project-Menu-controller', ->
  $scope      = null
  routeParams = null
  project     = 'bsimm'
  team        = 'team-A'  
  
  beforeEach ->
    module('MM_Graph')

  beforeEach ->
    inject ($controller, $rootScope)->
      $scope = $rootScope.$new()
      routeParams = project : project , team: team
      $controller('ProjectMenuController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->
      @.project     .assert_Is project
      @.base_Path   .assert_Is "/view/project/#{project}"
      @.links.size().assert_Is 5
      texts = (link.text for link in @.links)
      texts.assert_Is [ 'schema', 'schema (details)', 'scores', 'observed', 'observed (details)' ]

  it 'is_Active', ->
    inject ($location)->
      base_Path        = "/view/project/#{project}"
      using $scope.is_Active, ->
        @(''    ).assert_Is ''

        $location.url(base_Path)
        @('schema').assert_Is ''
        @('scores').assert_Is ''
        @('observed' ).assert_Is ''

        $location.url(base_Path+'/schema')
        @('schema').assert_Is 'active'
        @('scores').assert_Is ''
        @('observed' ).assert_Is ''

        $location.url(base_Path+'/scores')
        @('schema').assert_Is ''
        @('scores').assert_Is 'active'
        @('observed' ).assert_Is ''

  it 'Issue 211 - Project highlight does not work with request params', ->
    inject ($location)->
      base_Path        = "/view/project/#{project}"
      using $scope.is_Active, ->
        $location.url(base_Path+'/observed')
        @('observed' ).assert_Is 'active'

        $location.url(base_Path+'/observed?level=aaaaa')
        @('observed' ).assert_Is 'active'               # expected value