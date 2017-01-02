#to be deleted
describe 'directive | team-menu', ->
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
      element = angular.element('<teamMenu/>')[0] 
      $scope   = $rootScope.$new()
      $compile(element)($scope)
      $scope.$apply()
      html     = element.outerHTML

  it 'should have foundation css', ->
    $(html).find('dl')[0]['className'].assert_Is 'sub-nav'

  it 'should contain navigation links', ->
    links = (text:a.text, href: a.href for a in $(html).find('a'))
    links.size().assert_Is 8
    index = 0
    check_Link = (path, text) ->
      links[index  ].href.assert_Contains path
      links[index++].text.assert_Is text

    check_Link "/view/project/#{project}"             , project
    check_Link "/view/#{project}/#{team}/radar"       , 'radar'        # note these links need to be tested in sequence
    check_Link "/view/#{project}/#{team}/table"       , 'table'
    check_Link "/view/#{project}/#{team}/yes-answers" , 'yes answers'
    check_Link "/view/#{project}/#{team}/edit"        , 'edit'
    check_Link "/view/#{project}/#{team}/metadata"    , 'metadata'
    check_Link "/view/#{project}/#{team}/raw"         , 'raw'

  #it 'check menu active status', ->
  #  inject ($location)->
  #    console.log $location.path()


