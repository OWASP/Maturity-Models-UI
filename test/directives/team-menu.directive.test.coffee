#to be deleted
describe '| directive | team-menu', ->
  project = 'bsimm'
  team    = 'team-A'
  element = null
  $scope  = null
  html    = null

  beforeEach ()->
    module('MM_Graph')

  beforeEach ->
    inject ($rootScope, $compile, $templateCache, $routeParams)->
      $routeParams.project = project
      $routeParams.team    = team
      $templateCache.put '/ui/html/directives/team-menu.html', $templateCache.get('directives/team-menu.html')
      element = angular.element('<teamMenu/>')[0] 
      $scope   = $rootScope.$new()
      $compile(element)($scope)
      $scope.$apply()
      html     = element.outerHTML

  it 'should have foundation css', ->
    $(html).find('dl')[0]['className'].assert_Is 'sub-nav'

  it 'should contain navigation links', ->
    links = (text:a.text, href: a.href for a in $(html).find('a'))
    links.size().assert_Is 6

    index = 0
    check_Link = (path, text) ->
      links[index  ].href.assert_Contains path
      links[index++].text.assert_Is text

    check_Link "/view/project/#{project}"        , project
    check_Link "/view/#{project}/#{team}"        , 'view'
    check_Link "/view/#{project}/#{team}/table"  , 'table'
    check_Link "/view/#{project}/#{team}/radar"  , 'radar'
    check_Link "/view/#{project}/#{team}/edit"   , 'edit'
    check_Link "/view/#{project}/#{team}/raw"    , 'raw'

  #it 'check menu active status', ->
  #  inject ($location)->
  #    console.log $location.path()


