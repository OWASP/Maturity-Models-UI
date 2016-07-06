app = angular.module('MM_Graph')

class MM_Graph_API
  constructor: (http)->
    @.$http   = http
    @.version = '/api/v1'

  routes: (callback)=>
    url = "/api/v1/routes/list"
    @.$http.get url
           .success callback

  data_Radar: (project, team, callback)=>
    url = "#{@.version}/data/#{project}/#{team}/radar"
    @.$http.get url
      .success callback

  data_Score: (project, team, callback)=>
    url = "#{@.version}/data/#{project}/#{team}/score"
    @.$http.get url
      .success callback

  file_Get: (project, team,callback)=>
    url = "/api/v1/team/#{project}/get/#{team}?pretty"
    @.$http.get url
      .success callback


  file_Save: (project,team,data, callback)=>
    url = "/api/v1/team/#{project}/save/#{team}"
    @.$http.post(url, data)
           .success (data)->
              callback data

  project_List: (callback)=>
    url = "/api/v1/project/list"
    @.$http.get url
           .success callback

  project_Get: (project,callback)=>
    url = "/api/v1/project/get/#{project}"
    @.$http.get url
           .success callback

  project_Schema: (project,callback)=>
    url = "/api/v1/project/schema/#{project}"
    @.$http.get url
           .success callback

  project_Scores: (project,callback)=>
    url = "/api/v1/project/scores/#{project}"
    @.$http.get url
      .success callback

  view_Table: (project,team,callback)=>
    url = "/api/v1/table/#{project}/#{team}"
    @.$http.get url
      .success callback


app.service 'MM_Graph_API', ($http)=>
  return new MM_Graph_API $http