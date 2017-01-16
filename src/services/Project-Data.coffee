app = angular.module('MM_Graph')

class Project_Data
  constructor: ($routeParams, API)->
    @.$routeParams   = $routeParams
    @.API            = API
    @.activities     = null
    @.project        = null
    @.schema         = null
    @.schema_Details = null
    @.scores         = null
    @.teams          = null

  # Load all project data required for the multiple project views
  load_Data: (callback)=>
    if @.$routeParams.project and @.$routeParams.project != @.project
      @.project = @.$routeParams.project
      @.API.project_Get @.project, (teams)=>
        @.API.project_Schema @.project, (schema)=>
          @.API.project_Schema_Details @.project, (schema_Details)=>
            @.API.project_Activities @.project, (activities)=>
              @.API.project_Scores @.project, (scores)=>
                @.activities     = activities
                @.scores         = scores
                @.schema         = schema
                @.schema_Details = schema_Details
                @.teams          = teams
                callback()
    else
        callback()



app.service 'project_Data', ($routeParams, API)=>
  return new Project_Data $routeParams, API