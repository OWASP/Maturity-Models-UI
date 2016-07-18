describe '_issues | regression', ->

  beforeEach ->
    module('MM_Graph')

  it 'Issues 139 - View team is broken for new teams (edit page)', ->
    project       = 'bsimm'
    team          = 'aaaaaa-bbb'
    team_Data_Url = "/api/v1/team/#{project}/get/#{team}"
    team_Data     = {}

    options =
      url_Location    : "/view/#{project}/#{team}/edit"
      url_Template_Key: 'pages/.page.html'

    inject ($injector)->
      $injector.get('Render_View')(options)
                      .set_Expect_Get team_Data_Url, team_Data
                      .run()
                      .html.assert_Contains('TeamEditController')

  it 'Issues 139 - View team is broken for new teams (edit page)', ->
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