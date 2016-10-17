app = angular.module('MM_Graph')

class Team_Data
  constructor: (MM_API)->
    @.project = null
    @.team    = null
    @.schema  = null
    @.MM_API  = MM_API


  load: (project, team, callback)=>
    @.project = project
    @.team    = team
    if @.project and @.team
      @.MM_API.project_Schema project, (schema)=>
        @.MM_API.data_Score @.project, @.team, (scores)=>
          @.MM_API.team_Get @.project, @.team, (data)=>
            @.scores = scores
            @.schema = schema
            @.data = data

            callback()
    else
      callback()



app.service 'Team_Data', (MM_API)=>
  return new Team_Data MM_API