app = angular.module('MM_Graph')

class MM_API                                                          # Rename MM-API class (in ui project) #183
  constructor: (http)->
    @.$http   = http
    @.version = '/api/v1'

  _GET: (url, callback)=>
    @.$http.get url
           .then (response)->                                         # response object also has: status, statusText, headers() and config
              callback response.data, response.status
           .catch (response)->
              console.log "Error in request: '#{url}': #{response.data}"      # Client site MM_API errors are not handled #200
              callback null, response.data, response.status


  routes: (callback)=>
    url = "/api/v1/routes"
    @.$http.get url
           .then (response)-> callback response.data

  data_Radar_Team: (project, team, callback)=>
    url = "#{@.version}/data/#{project}/#{team}/radar"
    @.$http.get url
           .then (response)-> callback response.data

#  data_Radar_Fields: (project, callback)=>
#    url = "#{@.version}/data/#{project}/radar/fields"
#    @.$http.get url
#           .then (response)-> callback response.data

#  data_Score: (project, team, callback)=>
#    url = "#{@.version}/data/#{project}/#{team}/score"
#    @.$http.get url
#           .then (response)-> callback response.data

#  team_Get: (project, team,callback)=>
#    url = "/api/v1/team/#{project}/get/#{team}"
#    @.$http.get url
#           .then (response)-> callback response.data

  file_Save: (project,team,data, callback)=>
    url = "/api/v1/team/#{project}/save/#{team}"
    @.$http.post(url, data)
           .then (response)-> callback response.data

  data_Radar_Fields : (project,       callback)=> @._GET "#{@.version}/data/#{project}/radar/fields"   , callback
  data_Score        : (project, team, callback)=> @._GET "#{@.version}/data/#{project}/#{team}/score"  , callback
  team_Get          : (project, team, callback)=> @._GET "/api/v1/team/#{project}/get/#{team}"         , callback

  project_Activities: (project,callback       )=> @._GET "/api/v1/project/activities/#{project}"       , callback
  project_Get       : (project,callback       )=> @._GET "/api/v1/project/get/#{project}"              , callback
  project_List      : (        callback       )=> @._GET "/api/v1/project/list"                        , callback
  project_Schema    : (project,callback       )=> @._GET "/api/v1/project/schema/#{project}"           , callback

  project_Scores: (project,callback)=>
    url = "/api/v1/project/scores/#{project}"
    @.$http.get url
           .then (response)-> callback response.data

  team_Delete: (project, team, callback)=>
    url = "/api/v1/team/#{project}/delete/#{team}"
    @.$http.get url
           .then (response)-> callback response.data

  team_New: (project, callback)=>
    url = "/api/v1/team/#{project}/new"
    @.$http.get url
           .then (response)-> callback response.data



app.service 'MM_API', ($http)=>
  return new MM_API $http