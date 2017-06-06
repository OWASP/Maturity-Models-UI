describe 'controllers | team | Team-Menu-Controller', ->
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
      $controller('TeamMenuController', { $scope: $scope, $routeParams : routeParams })

  it '$controller',->
    using $scope, ->
      @.project     .assert_Is project
      @.team        .assert_Is team
      @.base_Path   .assert_Is "/view/#{project}/#{team}"
      @.links.size().assert_Is 7
      texts = (link.text for link in @.links)
      texts.assert_Is [ 'radar', 'table', 'yes answers', 'edit', 'metadata', 'raw', 'admin' ]

  it 'is_Active', ->
    inject ($location)->
      base_Path        = "/view/#{project}/#{team}"
      using $scope.is_Active, ->
        @(''    ).assert_Is ''

        $location.url(base_Path)
        @('view').assert_Is 'active'
        @('edit').assert_Is ''
        @('raw' ).assert_Is ''

        $location.url(base_Path+'/raw')
        @('view').assert_Is ''
        @('edit').assert_Is ''
        @('raw' ).assert_Is 'active'

        $location.url(base_Path+'/edit')
        @('view').assert_Is ''
        @('edit').assert_Is 'active'
        @('raw' ).assert_Is ''
