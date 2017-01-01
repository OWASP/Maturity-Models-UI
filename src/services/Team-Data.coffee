app = angular.module('MM_Graph')

class Team_Data
  constructor: ($routeParams,$rootScope, $cacheFactory, $q, API)->
    @.$routeParams  = $routeParams
    @.$rootScope    = $rootScope
    @.$cacheFactory = $cacheFactory
    @.cache         = $cacheFactory('team_Data')
    @.$q            = $q
    @.deferred      = null
    @.API           = API
    @.project       = null
    @.data          = null
    @.team          = null
    @.schema        = null

#      app.factory '$httpOnce', [
#        '$http'
#        '$cacheFactory'
#        ($http, $cacheFactory) ->
#          cache = $cacheFactory('$httpOnce')
#          (url, options) ->
#            cache.get(url) or cache.put(url, $http.get(url, options).then((response) ->
#              response.data
#            ))
#      ]

  load_Data: (callback)=>
    if not (@.$routeParams.project and @.$routeParams.team)                     # check that project and team are set
      return callback()

    if (@.$routeParams.project is @.project and @.$routeParams.team is @.team)  # check if either the project or team have changed
      # do nothing here
    else
      @.project = @.$routeParams.project
      @.team    = @.$routeParams.team

      @.API.project_Schema @.project, (schema)=>
        @.API.data_Score @.project, @.team, (scores)=>
          @.API.team_Get @.project, @.team, (data)=>
            @.scores = scores
            @.schema = schema
            @.data   = data

            @.deferred.resolve()                                                  # trigger promise resolve

    @.deferred ?= @.$q.defer()                                                  # ensure @.deferred object exits
    @.deferred.promise.then ->                                                  # schedule execution
      callback()                                                                # invoke original caller callback

  radar_Fields: (callback)->
    console.log @.cache.get('radar_Fields') or

    @.API.data_Radar_Fields @.project, (data_Fields)=>
      callback data_Fields

  radar_Team: (target_Team, callback)->
    @.API.data_Radar_Team @.project, target_Team, (data_Radar)->
      callback data_Radar

#  load: (project, team)=>
#    @.project = project
#    @.team    = team
#    if @.project and @.team
#      @.API.project_Schema project, (schema)=>
#        @.API.data_Score @.project, @.team, (scores)=>
#          @.API.team_Get @.project, @.team, (data)=>
#            @.scores = scores
#            @.schema = schema
#            @.data = data
#            @.notify()
#
#  load_From_Cache: (project, team)=>
#      if @.project is project and @.team is team                    # check if project and team have changed
#        if @.scores and @.schema and @.data                         # check if data has been loaded
#          return @.notify()
#      @.load project, team


  save: (callback)=>
    @.API.file_Save @.project, @.team , @.data, callback


#  notify: ()=>
#    @.$rootScope.$emit('team-data-event');
#
#  subscribe: (scope, callback)=>
#    event_Unsubscribe = @.$rootScope.$on('team-data-event', callback)
#    scope?.$on? '$destroy', ->
#      event_Unsubscribe()



app.service 'team_Data', ($routeParams, $rootScope, $cacheFactory, $q, API)=>
  return new Team_Data $routeParams, $rootScope, $cacheFactory, $q, API