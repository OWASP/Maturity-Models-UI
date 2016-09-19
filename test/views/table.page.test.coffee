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
        @.expectGET("/api/v1/project/schema/#{project}"    ).respond({});
        @.expectGET("/api/v1/data/#{project}/#{team}/score").respond({});
        @.expectGET("/api/v1/team/#{project}/get/#{team}"  ).respond({});

      view = $injector.get('Render_View')(options).run()

  it 'pages/table.page.html', ->
    using view, ->
      @.$('teamMenu').length.assert_Is 1
      @.$('teamTable').length.assert_Is 3
      @.$('.callout').length.assert_Is 3
      (item.innerHTML for item in @.$('.callout')).assert_Is [ 'Level 1 - ', 'Level 2 - ', 'Level 3 - ' ]
      @.$('table'    ).length.assert_Is 3
      @.$('th'       ).length.assert_Is 33

      @.$('td'       ).length.assert_Is 0           # this is a bug

      #console.log @.$('th').eq(1).html()