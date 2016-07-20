describe '_issues | bugs', ->

  beforeEach ->
    module('MM_Graph')

  it 'Issues 140 - View team is loading schema 3 times', ->
    project       = 'bsimm'
    team          = 'aaaaaa-bbb'
    options =
      url_Location    : "/view/#{project}/#{team}/table"
      url_Template_Key: 'pages/.page.html'

    inject ($injector)->
      $injector.get('Render_View')(options)
               .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}
               .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}
               .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}
               .set_Expect_Get "/api/v1/team/#{project}/get/#{team}"  , {}
               .set_Expect_Get "/api/v1/team/#{project}/get/#{team}"  , {}
               .set_Expect_Get "/api/v1/team/#{project}/get/#{team}"  , {}
               .run()
               .html.assert_Contains('<div id="teamMenu">')

  it 'Issues 144 - There are two Raw titles in the Routes page', ->
    inject ($injector)->
      using $injector.get('Render_View')(url_Location : "/view/routes").run(),->
        @.$('b').length.assert_Is 2
        @.$('b').eq(0).html().assert_Is 'Raw'
        @.$('b').eq(1).html().assert_Is 'Fixed'










