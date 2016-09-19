angular.module('MM_Graph')
  .controller 'TeamDataController', ($scope, $routeParams, MM_API)->

    using $scope, ->
      @.capture_Params = ()=>
        @.project = $routeParams.project
        @.team    = $routeParams.team

      @.load_Data = ()=>
        if @.project and @.team
          MM_API.project_Schema @.project, (schema)=>
            @.schema = schema
            MM_API.data_Score @.project, @.team, (scores)=>
              @.scores = scores
              MM_API.team_Get @.project, @.team, (data)=>
                @.data = data


    $scope.capture_Params()

    $scope.load_Data()



