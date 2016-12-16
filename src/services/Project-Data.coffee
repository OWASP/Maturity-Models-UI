app = angular.module('MM_Graph')

class Project_Data
  constructor: ($routeParams, API)->
    @.$routeParams = $routeParams
    @.API          = API
    @.activities   = null
    @.project      = null
    @.schema       = null
    @.scores       = null
    @.teams        = null

  # Load all project data required for the multiple project views
  load_Data: (callback)=>
    console.log  "in Project_Data.load_Data: " + JSON.stringify(@.$routeParams)

    if @.$routeParams.project and @.$routeParams.project != @.project
      @.project = @.$routeParams.project
      @.API.project_Get @.project, (teams)=>
        @.API.project_Schema @.project, (schema)=>
          @.API.project_Activities @.project, (activities)=>
            @.API.project_Scores @.project, (scores)=>
              @.activities  = activities
              @.scores      = scores
              @.schema      = schema
              @.teams       = teams
              callback()
    else
        callback()



app.service 'project_Data', ($routeParams, API)=>
  return new Project_Data $routeParams, API