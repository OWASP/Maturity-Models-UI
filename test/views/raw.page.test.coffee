describe 'views | raw.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  options =
    project         : project
    team            : team
    url_Data        : path: "/api/v1/team/#{project}/get/#{team}?pretty" , value: { metadata: 42}
    url_Location    : "/view/#{project}/#{team}/raw"
    url_Template_Key: 'pages/raw.page.html'

  view = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      view = $injector.get('Render_View')(options).run()

  #afterEach ()->
  #  inject ($httpBackend)->
  #    $httpBackend.verifyNoOutstandingExpectation()
      
  it 'pages/view.page.html', -> 
    using view, ->
      @.$('div').attr('ng-controller').assert_Is 'TeamRawController'
      @.$('.sub-nav #raw').attr('id'   ).assert_Is 'raw'
      @.$('.sub-nav #raw').attr('class').assert_Is 'active' 

    