describe 'views | team | edit.page', ->

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
      $scope   = $rootScope.$new()
      raw_Html = $templateCache.get '/ui/html/pages/team/edit.html'
      element  = $compile(angular.element(raw_Html))($scope)
      $httpBackend.flush()

      $scope = element.scope()      
      html   = element[0].outerHTML
      $html  = $(html)

 
  it 'check with Controller', ()->
    using $scope, ->
      @.project.assert_Is project
      @.team   .assert_Is team
      @.team_Data.data.metadata.team.assert_Is 'Team A'
      @.domains.keys().assert_Is [ 'Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]

    using element,->
      @.find('teamMenu').find('a')[0].href.assert_Contains "/view/project/#{project}"
    
      @.find('input').val().assert_Is 'Team A'
      $html.find('a.button'     ).html().assert_Is 'save'

      @.find('activityTable').length.assert_Is 4
      $html.find('#Governance').length.assert_Is 1
      $html.find('#Governance input').length.assert_Is 136


  it 'should keep input value inSync with scope', ->
    
    using $html.find('activitytable tbody tr td'),->
      @.eq(0).html().assert_Is 'SM.1.1'
      @.eq(1).find('input').val().assert_Is 'Yes'
      @.eq(2).find('input').val().assert_Is 'No'
      @.eq(3).find('input').val().assert_Is 'NA'
      @.eq(4).find('input').val().assert_Is 'Maybe'      
    
    $html.find('tr[id="SM.1.1"]').length.assert_Is 1

