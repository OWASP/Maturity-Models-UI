describe '_issues | regression', ->

  beforeEach ->
    module('MM_Graph')

#  rewrite to test save better from UI
#
#  it 'Issue 120 - Save is broken', (done)->
#    project       = 'bsimm'
#    team          = 'aaaaaa-bbb'
#    options =
#      url_Location    : "/view/#{project}/#{team}/edit"
#      url_Template_Key: 'pages/.page.html'
#
#    inject ($injector)->
#      view = $injector.get('Render_View')(options)
#                      .set_Expect_Get "/api/v1/data/#{project}/#{team}/score", {}
#                      .set_Expect_Get "/api/v1/team/#{project}/get/#{team}", {}
#                      .run()
#
#      scope = view.scope.$$childTail.$$childTail                                  # get scope for TeamEditController
#
#      scope.project                .assert_Is project                             # confirm data is loaded
#      scope.team                   .assert_Is team
#      scope.messageClass           .assert_Is 'secondary'
#      scope.team_Data.data.metadata.assert_Is team: ''
#      (typeof scope.team_Data.schema  ).assert_Is 'object'
#      (typeof scope.team_Data.data    ).assert_Is 'object'
#      (typeof scope.domains ).assert_Is 'object'
#
#      #scope.team_Data.save ->
#        #scope.messageClass.assert_Is 'alert'                                        # confirm save error message
#      using view,->
#        console.log @.$('#status-label').html()
#        console.log @.$('#save-button')
#        angular.element(@.$('#save-data')).triggerHandler('click')
#        console.log @.$('#save-button').triggerHandler('click')
#        scope.$digest()
#
#        console.log @.$('#status-label').html()
#        #console.log view
#        #scope.status      .assert_Is 'not 42'                                       # is set ok from data received
#
##    inject ($httpBackend, $timeout)->
##    #  bad_Data_Submission = metadata : team: ''
##    #  $httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}", bad_Data_Submission).respond { error: 'not 42'}
##      $httpBackend.flush()
#
#      #$httpBackend.expectPOST("/api/v1/team/#{project}/save/#{team}").respond {}

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