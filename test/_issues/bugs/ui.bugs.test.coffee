describe '_issues | bugs', ->

  beforeEach ->
    module('MM_Graph')

  it 'Issues 144 - There are two Raw titles in the Routes page', ->
    inject ($injector)->
      using $injector.get('Render_View')(url_Location : "/view/routes").run(),->
        @.$('b').length.assert_Is 2
        @.$('b').eq(0).html().assert_Is 'Raw'
        @.$('b').eq(1).html().assert_Is 'Fixed'










