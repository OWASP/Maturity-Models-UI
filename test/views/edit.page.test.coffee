describe 'views | edit.page', ->

  html       = null
  project    = null
  team       = null  

  element  = null
  html     = null
  raw_Html = null
  $html    = null
  $scope   = null

  beforeEach ()->
    module('MM_Graph')
    project = 'bsimm'
    team    = 'team-A'

    inject ($templateCache, $compile, $rootScope, $routeParams, $httpBackend)->      
      $routeParams.project = project
      $routeParams.team    = team
      $templateCache.put '/ui/html/directives/team-menu.html'     , $templateCache.get 'directives/team-menu.html'
      $templateCache.put '/ui/html/directives/activity-table.html', $templateCache.get 'directives/activity-table.html'
      #$httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond bsimm_Team

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
      @.data.metadata.team.assert_Is 'Team A'      
      @.metadata.assert_Is team : 'Team A'      
      @.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL', 'Deployment' ]

    using element,->
      @.find('teamMenu').find('a')[0].href.assert_Contains "/view/project/#{project}"  # confirm menu is there
      @.find('input').val().assert_Is 'Team A'                # using this one since             
      #element.find('#team-name').val()                       # searching for input ID doesn't seem to be working
      #$html.find('#team-name')[0]
      $html.find('a.button').html().assert_Is 'save'
      $html.find('#message').html().assert_Is 'data loaded'

      @.find('activityTable').length.assert_Is 4
      $html.find('#Governance').length.assert_Is 1
      $html.find('#Governance input').length.assert_Is 84


  it 'should keep input value inSync with scope', ->

    $scope. metadata.team.assert_Is 'Team A'
    element.find('input').val().assert_Is 'Team A'

    element.find('input').val('AAAAA').triggerHandler('input')
    $scope. $digest()
    element.find('input').val().assert_Is 'AAAAA'
    $scope .metadata.team.assert_Is 'AAAAA'

    $scope .metadata.team = 'BBBBB'
    $scope .$digest()
    element.find('input').val().assert_Is 'BBBBB'

