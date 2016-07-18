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


  it 'Issue 120 - Save is broken', ->
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
      (typeof scope.schema        ).assert_Is 'object'
      (typeof scope.data          ).assert_Is 'object'
      (typeof scope.domains       ).assert_Is 'object'
      (scope.metadata is undefined).assert_Is_True()


      scope.save_Data()
      bad_Data_Submission = {}                                                    # this is the wrong value

      view.$httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", bad_Data_Submission).respond { error: 'not 42'}
      view.$httpBackend.flush()

      scope.messageClass.assert_Is 'alert'                                        # confirm save error message
      scope.status      .assert_Is 'not 42'                                       # is set ok from data received










