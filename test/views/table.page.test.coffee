describe 'views | table.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  options =
    project         : project
    team            : team
    url_Location    : "/view/#{project}/#{team}/table"
    url_Template_Key: 'pages/table.page.html'

  view = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector, $httpBackend)->
      using ($httpBackend),->
        @.expectGET("/api/v1/project/schema/#{project}"    )
        @.expectGET("/api/v1/data/#{project}/#{team}/score")
        @.expectGET("/api/v1/team/#{project}/get/#{team}"  )

      view = $injector.get('Render_View')(options).run()

  it 'pages/table.page.html', ->
    using view, ->
      @.$('teamMenu' ).length.assert_Is 1
      @.$('teamTable').length.assert_Is 3
      @.$('.callout' ).length.assert_Is 3

      @.$('table'    ).length.assert_Is 3     # tables
      @.$('th'       ).length.assert_Is 33    # table headers
      @.$('tr'       ).length.assert_Is 115   # rows
      @.$('td'       ).length.assert_Is 1232  # cells