describe 'services | UI-Status', ->

  ui_Status      = null


  beforeEach ()->
    module('MM_Graph')
    inject ($injector)->
      ui_Status = $injector.get('ui_Status')

  it 'constructor', ->
    using ui_Status, ->
      (typeof @.$injector ).assert_Is 'object'
      (typeof @.$rootScope).assert_Is 'object'

  it 'set_Default_Values', ->
    using ui_Status.set_Default_Values(), ->
      @.team_Table_Fields.Domain.assert_Is_True()