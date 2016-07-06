describe 'views | edit.page', ->

  html       = null
  project    = null
  team       = null
  bsimm_Team = null
  samm_Team  = null

  element  = null
  html     = null
  raw_Html = null
  $html    = null
  $scope   = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'

    inject ($templateCache, $compile, $rootScope, $routeParams, $httpBackend, test_Data)->
      bsimm_Team = test_Data.bsimm_Team
      samm_Team  = test_Data.samm_Team
      $routeParams.project = project
      $routeParams.team    = team
      $templateCache.put '/ui/html/directives/team-menu.html'     , $templateCache.get 'directives/team-menu.html'
      $templateCache.put '/ui/html/directives/activity-table.html', $templateCache.get 'directives/activity-table.html'
      $httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond bsimm_Team

      $scope   = $rootScope.$new()
      raw_Html = $templateCache.get 'pages/edit.page.html'
      element  = $compile(angular.element(raw_Html))($scope)
      $httpBackend.flush()

      $scope = element.scope()
      html   = element[0].outerHTML
      $html  = $(html)


  it 'check with Controller', ()->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.status .assert_Is 'data loaded'
      @.data   .assert_Is bsimm_Team
      @.metadata.assert_Is team : 'Team BSIMM'      
      @.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL', 'Deployment' ]

    using element,->
      @.find('teamMenu').find('a')[0].href.assert_Contains "/view/project/#{project}"  # confirm menu is there
      @.find('input').val().assert_Is 'Team BSIMM'            # using this one since             
      #element.find('#team-name').val()                       # searching for input ID doesn't seem to be working
      #$html.find('#team-name')[0]
      $html.find('a.button').html().assert_Is 'save'
      $html.find('#message').html().assert_Is 'data loaded'

      @.find('activityTable').length.assert_Is 4
      $html.find('#Governance').length.assert_Is 1
      $html.find('#Governance input').length.assert_Is 80


  it 'should keep input value inSync with scope', ->

    $scope. metadata.team.assert_Is 'Team BSIMM'
    element.find('input').val().assert_Is 'Team BSIMM'

    element.find('input').val('AAAAA').triggerHandler('input')
    $scope. $digest()
    element.find('input').val().assert_Is 'AAAAA'
    $scope .metadata.team.assert_Is 'AAAAA'

    $scope .metadata.team = 'BBBBB'
    $scope .$digest()
    element.find('input').val().assert_Is 'BBBBB'
  
#        using $(element.find('a')), ->
#          @.length.assert_Is 2
#          using @.eq(0), ->
#            @.attr('href').assert_Is 'view/demo/team-A/table'
#            @.html().assert_Is 'team-A'
#          using @.eq(1), ->
#            @.attr('href').assert_Is 'view/demo/team-B/table'
#            @.html().assert_Is 'team-B'


