describe 'views | radar.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys().assert_Contains '/ui/html/pages/team/radar.html'
      html = $templateCache.get '/ui/html/pages/team/radar.html'

  it 'check raw template value',->  
    using $(html), ->
      html.assert_Contains '<div ng-controller="RadarController"'