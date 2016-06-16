describe 'angular | templates', ->
  beforeEach ()->
    module('MM_Graph')

  it 'check setup',->
    inject ($templateCache)->
      $templateCache.keys().assert_Is [ 'put', 'get', 'remove', 'removeAll', 'destroy', 'info' , 'get_Keys']
      $templateCache.info().id.assert_Is 'templates'


  it 'check values',->
    inject ($templateCache)->
      $templateCache.get_Keys().size().assert_Is $templateCache.info().size

      $templateCache.get('angular-page.html'       ).assert_Contains 'html'
      $templateCache.get('index.html'              ).assert_Contains 'html'
      $templateCache.get('pages/projects.page.html').assert_Contains 'ng-controller'