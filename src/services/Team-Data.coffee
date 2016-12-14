app = angular.module('MM_Graph')

class Team_Data
  constructor: ($rootScope, API)->
    @.$rootScope = $rootScope
    @.API     = API
    @.project    = null
    @.data       = null
    @.team       = null
    @.schema     = null

  load: (project, team)=>
    @.project = project
    @.team    = team
    if @.project and @.team
      @.API.project_Schema project, (schema)=>
        @.API.data_Score @.project, @.team, (scores)=>
          @.API.team_Get @.project, @.team, (data)=>
            @.scores = scores
            @.schema = schema
            @.data = data
            @.notify()

  load_From_Cache: (project, team)=>
      if @.project is project and @.team is team                    # check if project and team have changed
        if @.scores and @.schema and @.data                         # check if data has been loaded
          return @.notify()
      @.load project, team


  save: (callback)=>
    @.API.file_Save @.project, @.team , @.data, callback


  notify: ()=>
    @.$rootScope.$emit('team-data-event');

  subscribe: (scope, callback)=>
    event_Unsubscribe = @.$rootScope.$on('team-data-event', callback)
    scope?.$on? '$destroy', ->
      event_Unsubscribe()



app.service 'Team_Data', ($rootScope, API)=>
  return new Team_Data $rootScope, API