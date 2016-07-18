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











