describe 'views | radar.page', ->

  html = null

  beforeEach ()->
    module('MM_Graph')
    inject ($templateCache)->
      $templateCache.get_Keys().assert_Contains '/ui/html/pages/radar.page.html'
      html = $templateCache.get '/ui/html/pages/radar.page.html'

  it 'check raw template value',->  
    using $(html), ->
      html.assert_Contains '<div ng-controller="RadarController"'