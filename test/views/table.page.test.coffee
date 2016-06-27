describe 'views | table.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  options =
    project         : project
    team            : team
    url_Data        : path: "/api/v1/table/#{project}/#{team}" , value: { metadata: 42}
    url_Location    : "/view/#{project}/#{team}/table"
    url_Template_Key: 'pages/table.page.html'

  view = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      view = $injector.get('Render_View')(options).run()

  it 'pages/view.page.html', ->
    view.$('h1').html().assert_Is 'table will go here'
    view.$('pre').html().assert_Is '{"metadata":42}'
    view.route.$$route.controller.assert_Is 'TableController'


    