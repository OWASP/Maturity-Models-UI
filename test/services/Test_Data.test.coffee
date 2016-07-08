describe 'services | Test_Data', ->

  test_Data  = null
  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      test_Data = $injector.get('test_Data')

  it 'constructor', ->
    using test_Data, ->
      @.items.assert_Is ['bsimm_Schema', 'team_A']

  it 'bsimm_Schema', ->
    using test_Data.bsimm_Schema, ->
      @["SM.1.1"].assert_Is "level" :"1", "activity" : "Is there a formal SDL (Software Development Lifecycle) used?"

  it 'bsimm_Team', ->
    using test_Data.bsimm_Team, ->
      @.metadata.team.assert_Is 'Team BSIMM'
      @.activities.keys().assert_Is ['Governance', 'Intelligence', 'SSDL', 'Deployment']

  it 'samm_Team', ->
    using test_Data.samm_Team, ->
      @.metadata.team.assert_Is 'Team SAMM'
      @.activities.keys().assert_Is ['Governance', 'Construction', 'Verification', 'Operation']

  it '/project/schema/bsimm', ->
    inject ($httpBackend, MM_Graph_API)->
      MM_Graph_API.project_Schema 'bsimm', (data)-> 
        data.domains.keys().assert_Is ['Governance', 'Intelligence', 'SSDL Touchpoints', 'Deployment' ]
      $httpBackend.flush()

  it '/project/schema/samm', ->
    inject ($httpBackend, MM_Graph_API)->
      MM_Graph_API.project_Schema 'samm', (data)->
        data.keys().size().assert_Is 77
        data['SM.1.A'].domain.assert_Is 'Governance'
      $httpBackend.flush()
        





