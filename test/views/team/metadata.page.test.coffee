describe 'views | raw.page', ->

  project       = 'bsimm'
  team          = 'team-A'
  options =
    project         : project
    team            : team
    url_Location    : "/view/#{project}/#{team}/metadata"

  view = null


  beforeEach ()->  
    module('MM_Graph')
    inject ($injector)->
      view = $injector.get('Render_View')(options).run()  # no requests to flush in metadata



  it 'pages/team/metadata.page.html', ->
    using view, ->
      @.$('div').eq(0).attr('ng-controller').assert_Is 'TeamDataController'
      @.$('div').eq(1).attr('ng-controller').assert_Is 'TeamMetadataController'
      @.$('.sub-nav #metadata').attr('id'   ).assert_Is 'metadata'            # check that menu item exists
      @.$('.sub-nav #metadata').attr('class').assert_Is 'active'              # and it is set

      @.$('tr').length.assert_Is
      size = (@.$('td').length / 2) - 1
      names = for i in [0..size]
        @.$('td').eq(i*2).html()

        #value.html()
      names.assert_Is [ 'team', 'security-champion', 'source-code-repo', 'issue-tracking',
                        'wiki', 'ci-server'        , 'created-by'                          ]
