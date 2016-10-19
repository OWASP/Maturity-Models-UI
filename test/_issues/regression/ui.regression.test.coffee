describe '_issues | regression', ->

  beforeEach ->
    module('MM_Graph')

  xit 'Issues 139 - View team is broken for new teams (edit page)', ->
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

  xit 'Issue 120 - Save is broken', ->
    project       = 'bsimm'
    team          = 'aaaaaa-bbb'
    options =
      url_Location    : "/view/#{project}/#{team}/edit"
      url_Template_Key: 'pages/.page.html'

    inject ($injector)->
      view = $injector.get('Render_View')(options)
                      .set_Expect_Get "/api/v1/team/#{project}/get/#{team}", {}
                      .run()

      scope = view.scope.$$childTail.$$childTail                                  # get scope for TeamEditController

      scope.project                .assert_Is project                             # confirm data is loaded
      scope.team                   .assert_Is team
      scope.messageClass           .assert_Is 'secondary'
      scope.status                 .assert_Is 'data loaded'
      scope.metadata               .assert_Is team: ''
      (typeof scope.schema  ).assert_Is 'object'
      (typeof scope.data    ).assert_Is 'object'
      (typeof scope.domains ).assert_Is 'object'


      scope.save_Data()
      bad_Data_Submission = metadata : team: ''                                   #todo: improve test to also check for content changes (i.e. via the checkbox)

      view.$httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", bad_Data_Submission).respond { error: 'not 42'}
      view.$httpBackend.flush()

      scope.messageClass.assert_Is 'alert'                                        # confirm save error message
      scope.status      .assert_Is 'not 42'                                       # is set ok from data received

  it 'Issues 139 - View team is broken for new teams (edit page)', ->
    project       = 'bsimm'
    team          = 'aaaaaa-bbb'
    options =
      url_Location    : "/view/#{project}/#{team}/table"
      url_Template_Key: 'pages/.page.html'

    inject ($injector)->
      $injector.get('Render_View')(options)
               .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}      # there were 3 of these (before #140 fix)
               .set_Expect_Get "/api/v1/team/#{project}/get/#{team}"  , {}      # there were 3 of these (before #140 fix)
               .run()
               .html.assert_Contains('<div id="teamMenu">')

  it 'Issues 140 - View team is loading schema 3 times', ->
    project       = 'bsimm'
    team          = 'aaaaaa-bbb'
    options =
      url_Location    : "/view/#{project}/#{team}/table"
      url_Template_Key: 'pages/.page.html'

    inject ($injector)->
      $injector.get('Render_View')(options)
               .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}      # there were 3 of these (before fix)
               .set_Expect_Get "/api/v1/team/#{project}/get/#{team}"  , {}      # there were 3 of these (before fix)
               .run()
               .html.assert_Contains('<div id="teamMenu">')