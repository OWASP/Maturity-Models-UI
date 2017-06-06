# test not stable

#describe 'views | table.page', ->
#
#  project       = 'bsimm'
#  team          = 'team-A'
#  options =
#    project         : project
#    team            : team
#    url_Location    : "/view/#{project}/#{team}/table"
#
#  view = null
#
#
#  beforeEach ()->
#    module('MM_Graph')
#    inject ($injector, $httpBackend)->
#      using ($httpBackend),->
#        view = $injector.get('Render_View')(options).run()
#
#
#  afterEach ()->
#    inject ($httpBackend)->
#      $httpBackend.verifyNoOutstandingExpectation()
#      $httpBackend.verifyNoOutstandingRequest()
#
#
#  it 'pages/table.page.html', ->
#    using view, ->
#      @.$('teamMenu' ).length.assert_Is 1
#      @.$('teamTable').length.assert_Is 3
#      @.$('.callout' ).length.assert_Is 3
#
#      @.$('table'    ).length.assert_Is 3     # tables
#      @.$('th'       ).length.assert_Is 30    # table headers
#      @.$('tr'       ).length.assert_Is 115   # rows
#      @.$('td'       ).length.assert_Is 1232  # cells