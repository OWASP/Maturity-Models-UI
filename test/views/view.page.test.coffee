describe 'views | view.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  options =
    project         : project
    team            : team
    url_Data        : path :"/api/v1/table/#{project}/#{team}" , value: { metadata: 42}
    url_Location    : "/view/#{project}/#{team}"
    url_Template_Key: 'pages/view.page.html'

  view = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      using $injector.get('Render_View')(options), ->
        view = @
        @.$httpBackend.expectGET("/api/v1/team/#{project}/get/#{team}?pretty").respond {}
        @.run()

  it 'pages/view.page.html', ->
    $(view.html).eq(0).attr('ng-controller').assert_Is 'OldTableController'