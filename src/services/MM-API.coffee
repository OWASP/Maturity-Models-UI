app = angular.module('MM_Graph')

class MM_API                                                                # refactor: Rename MM-API class (in ui project) #183
  constructor: (http)->
    @.$http   = http
    @.version = '/api/v1'

  _GET: (url, callback)=>
    @.$http.get url
           .then (response)->                                               # response object also has: statusText, headers() and config
              callback response.data, response.status
           .catch (response)->
              console.log "Error in request: '#{url}': #{response.data}"    # risk: Client site MM_API errors are not handled #200
              callback null, response.data, response.status

  _POST: (url, data, callback)=>
    @.$http.post(url, data)
           .then (response)->                                               # response object also has: status, statusText, headers() and config
              callback response.data, response.status
           .catch (response)->
              console.log "Error in request: '#{url}': #{response.data}"    # Client site MM_API errors are not handled #200
              callback null, response.data, response.status

  # GET requests
  data_Radar_Fields : (project,       callback)=> @._GET "#{@.version}/data/#{project}/radar/fields"   , callback
  data_Radar_Team   : (project, team, callback)=> @._GET "#{@.version}/data/#{project}/#{team}/radar"  , callback
  data_Score        : (project, team, callback)=> @._GET "#{@.version}/data/#{project}/#{team}/score"  , callback
  project_Activities: (project,       callback)=> @._GET "#{@.version}/project/activities/#{project}"  , callback
  project_Get       : (project,       callback)=> @._GET "#{@.version}/project/get/#{project}"         , callback
  project_List      : (               callback)=> @._GET "#{@.version}/project/list"                   , callback
  project_Schema    : (project,       callback)=> @._GET "#{@.version}/project/schema/#{project}"      , callback
  project_Scores    : (project,       callback)=> @._GET "#{@.version}/project/scores/#{project}"      , callback
  routes            : (               callback)=> @._GET "#{@.version}/routes"                         , callback
  team_Delete       : (project, team, callback)=> @._GET "#{@.version}/team/#{project}/delete/#{team}" , callback
  team_Get          : (project, team, callback)=> @._GET "#{@.version}/team/#{project}/get/#{team}"    , callback
  team_New          : (project,       callback)=> @._GET "#{@.version}/team/#{project}/new"            , callback

  # POST requests
  file_Save         : (project,team, data, callback)=> @._POST "#{@.version}/team/#{project}/save/#{team}", data, callback

app.service 'MM_API', ($http)=>
  return new MM_API $http