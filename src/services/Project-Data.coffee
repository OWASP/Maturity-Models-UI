app = angular.module('MM_Graph')

class Project_Data
  constructor: ($routeParams, API)->
    @.$routeParams = $routeParams
    @.API          = API
    @.project      = null
    @.activities   = null
    @.schema       = null
    @.scores       = null

  # Load all project data required for the multiple project views
  load_Data: (callback)=>
    if @.$routeParams.project and @.$routeParams.project != @.project
      @.project = @.$routeParams.project
      @.API.project_Schema @.project, (schema)=>
        @.API.project_Activities @.project, (activities)=>
          @.API.project_Scores @.project, (scores)=>
            @.activities  = activities
            @.scores      = scores
            @.schema      = schema
            callback()
    else
        callback()



app.service 'project_Data', ($routeParams, API)=>
  return new Project_Data $routeParams, API