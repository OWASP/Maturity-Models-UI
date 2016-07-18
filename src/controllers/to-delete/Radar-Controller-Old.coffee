angular.module('MM_Graph')
  .controller 'RadarControllerOld', ($scope, $routeParams, MM_API)->
    $scope.version = 'v0.7.7'

    #level_1 = 'AppSec-Level-1'
    project  = $scope.project  || $routeParams.project
    team     = $scope.team     || $routeParams.team
    target_Div = '.chart-container' #'.chart-' + team

    if project  and team

      #MM_API.file_Get project, level_1,(level_1_Result)->

        #mapData level_1_Result, (level_1_Data)->
        #  console.log level_1_Data

          MM_API.file_Get project, team,(result)->
            if result?.metadata
              $scope.data = result
              $scope.team = result.metadata.team

              mapData result, (data)->
                showRadar(data)

    mapData = (result, next)->

      calculate = (activity, prefix)->
        score = 0.2
        for key,value of result.activities[activity] when key.contains(prefix)
          if value is 'Yes'
            score += 0.4
          if value is 'NA'
            score += 0.1
        score

      data =
        SM  : calculate 'Governance'  , 'SM'
        CMVM: calculate 'Deployment'  , 'CMVM'
        SE  : calculate 'Deployment'  , 'SE'
        PE  : calculate 'Deployment'  , 'SE'
        ST  : calculate 'SSDL'        , 'ST'
        CR  : calculate 'SSDL'        , 'CR'
        AA  : calculate 'SSDL'        , 'AA'
        SR  : calculate 'Intelligence', 'SR'
        SFD : calculate 'Intelligence', 'SFD'
        AM  : calculate 'Deployment'  , 'AM'
        T   : calculate 'Governance'  , 'T'
        CP  : calculate 'Governance'  , 'CP'
      next data

    radar_Config = ()->
      config =
        color: (index)->
              return ['black', 'orange', 'green'][index];
        w: 450,
        h: 450,
        levels: 6,
        maxValue: 3.0
      config

    get_Radar_Fields = ()->
      axes: [
        {axis: "Strategy & Metrics", xOffset: 1, value: 0},
        {axis: "Conf & Vuln Management", xOffset: -110, value: 0},
        {axis: "Software Environment", xOffset: -30, value: 0},
        {axis: "Penetration Testing", xOffset: 1, value: 0},
        {axis: "Security Testing", xOffset: -25, value: 0},
        {axis: "Code Review", xOffset: -60, value: 0},
        {axis: "Architecture Analysis", xOffset: 1, value: 0},
        {axis: "Standards & Requirements", xOffset: 100, value: 0},
        {axis: "Security Features & Design", xOffset: 30, value: 0},
        {axis: "Attack Models", xOffset: 1, value: 0},
        {axis: "Training", xOffset: 30, value: 0},
        {axis: "Compliance and Policy", xOffset: 100, value: 0},
      ]

    get_Default_Data = ()->
      axes: [
        {value: 2.0},  # Strategy & Metrics
        {value: 2.0},  # Configuration & Vulnerability Management
        {value: 1.8},  # Software Environment
        {value: 1.2},  # Penetration Testing
        {value: 1.5},  # Security Testing
        {value: 1.4},  # Code Review
        {value: 1.4},  # Architecture Analysis
        {value: 1.9},  # Standards & Requirements
        {value: 1.6},  # Security Features & Design
        {value: 1.3},  # Attack Models
        {value: 1.2},  # Training
        {value: 2.1},  # Compliance and Policy
      ]
    map_Team_Data = (data)->
      {        
        axes: [
          {value: data.SM  },  # Strategy & Metrics
          {value: data.CMVM},  # Configuration & Vulnerability Management
          {value: data.SE  },  # Software Environment
          {value: data.PE  },  # Penetration Testing
          {value: data.ST  },  # Security Testing
          {value: data.CR  },  # Code Review
          {value: data.AA  },  # Architecture Analysis
          {value: data.SR  },  # Standards & Requirements
          {value: data.SFD },  # Security Features & Design
          {value: data.AM  },  # Attack Models
          {value: data.T   },  # Training
          {value: data.CP  },  # Compliance and Policy
        ]
      }

    showRadar  = (team_Data,level_1_Data)->
      data = []
      data.push get_Radar_Fields()
      data.push get_Default_Data()
      #data.push map_Team_Data(level_1_Data)
      data.push map_Team_Data(team_Data)


      RadarChart.draw target_Div, data, radar_Config()