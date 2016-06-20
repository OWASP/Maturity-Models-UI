app = angular.module('MM_Graph')

class MM_Graph_API
  constructor: (http)->
    @.$http = http

  routes: (callback)=>
    url = "/api/v1/routes/list"
    @.$http.get url
           .success callback

  file_Get: (project, team,callback)=>
    url = "/api/v1/team/#{project}/get/#{team}?pretty"
    @.$http.get url
      .success callback

  file_List: (project, callback)=>
    url = "/api/v1/team/#{project}/list"
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

  view_Table: (project,team,callback)=>
    url = "/api/v1/table/#{project}/#{team}"
    @.$http.get url
      .success callback


app.service 'MM_Graph_API', ($http)=>
  return new MM_Graph_API $http