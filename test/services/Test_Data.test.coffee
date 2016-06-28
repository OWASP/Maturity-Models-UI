describe 'services | Test_Data', ->

  test_Data  = null
  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      test_Data = $injector.get('test_Data')

  it 'constructor', ->
    using test_Data, ->
      @.items.assert_Is ['bsimm_Schema']

  it 'bsimm_Schema', ->
    using test_Data.bsimm_Schema, ->
      @["SM.1.1"].assert_Is "level" :"1", "activity" : "Is there a formal SDL (Software Development Lifecycle) used?"