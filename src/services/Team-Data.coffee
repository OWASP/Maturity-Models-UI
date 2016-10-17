app = angular.module('MM_Graph')

class Team_Data
  constructor: ($rootScope, MM_API)->
    @.$rootScope = $rootScope
    @.MM_API     = MM_API
    @.project    = null
    @.team       = null
    @.schema     = null

  load: (project, team)=>
    @.project = project
    @.team    = team
    if @.project and @.team
      @.MM_API.project_Schema project, (schema)=>
        @.MM_API.data_Score @.project, @.team, (scores)=>
          @.MM_API.team_Get @.project, @.team, (data)=>
            @.scores = scores
            @.schema = schema
            @.data = data

            @.notify()

  load_From_Cache: (project, team)=>
      if @.project is project and @.team is team                    # check if project and team have changed
        if @.scores and @.schema and @.data                         # check if data has been loaded
          return @.notify()

      @.load project, team

  notify: ()=>
    @.$rootScope.$emit('team-data-event');

  subscribe: (scope, callback)=>
    event_Unsubscribe = @.$rootScope.$on('team-data-event', callback)
    scope?.$on? '$destroy', ->
      event_Unsubscribe()



app.service 'Team_Data', ($rootScope, MM_API)=>
  return new Team_Data $rootScope, MM_API