describe 'services | Keyboard', ->

  keyboard      = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      keyboard = $injector.get('keyboard')

  it 'constructor', ->
    using keyboard, ->
      (typeof @.$injector).assert_Is 'object'