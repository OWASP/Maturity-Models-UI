#to be deleted
describe '| directive | team-navbar', ->
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
      $templateCache.put '/ui/html/directives/team-navbar.html', $templateCache.get('directives/team-navbar.html')
      element = angular.element('<teamMenu/>')[0]
      $scope   = $rootScope.$new()
      $compile(element)($scope)
      $scope.$apply()
      html     = element.outerHTML

  it 'should have foundation css', ->
    $(html).find('dl')[0]['className'].assert_Is 'sub-nav'

  it 'should contain navigation links', ->
    links = (text:a.text, href: a.href for a in $(html).find('a'))
    links.size().assert_Is 5
    check_Link = (index, path, text) ->
      links[index].href.assert_Contains path
      links[index].text.assert_Is text

    check_Link 0, "/view/project/#{project}"        , project
    check_Link 1, "/view/#{project}/#{team}"        , 'view'
    check_Link 2, "/view/#{project}/#{team}/radar"  , 'radar'
    check_Link 3, "/view/#{project}/#{team}/edit"   , 'edit'
    check_Link 4, "/view/#{project}/#{team}/raw"    , 'raw'

