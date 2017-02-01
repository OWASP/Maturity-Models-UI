app = angular.module('MM_Graph')

class Observed
  constructor: ($routeParams, API, project_Data)->
    @.$routeParams   = $routeParams
    @.API            = API
    @.project_Data   = project_Data
    @.domains        = null
    @.observed       = null
    @.activities     = null
    @.schema         = null
    @.schema_Details = null


  activity_For_Key: (key)=>
    if key and @.activities
      for activity in @.activities
        if activity.key is key
          return activity
    return {}

  calculate_Observed: (activity_Data)=>
    return 0 if not activity_Data
    return (activity_Data['Yes']?.length || 0) + ((activity_Data['Maybe'  ]?.length || 0) )


  current_Level: ()=>
    @.$routeParams.level || null

  map_Activities: ()=>
    @.activities = []
    for domain_Name, domain_Data of @.observed
      for key, activity of domain_Data.activities
        @.activities.push activity
    @

  map_Data: ()=>
    @.map_Domains()
     .map_Observed()
     .map_Activities()

  map_Domains: ()=>
    schema           = @.project_Data.schema

    if schema
      @.domains     = {}
      for domain_Name, domain of schema.domains
        @.domains[domain_Name] = []
        for practice_Name in domain.practices
          @.domains[domain_Name] = @.domains[domain_Name].concat schema.practices[practice_Name].activities
    @

  map_Observed: (level)=>
    index = 0

    @.observed = {}

    for domain,activities of @.domains
      domain_Activities = {}

      for key in activities
        activity_Data   = @.project_Data       .activities[key]
        activity_Schema = @.project_Data.schema.activities[key]
        schema_Details  = @.project_Data.schema_Details?.activities[key]

        domain_Activities[key]=
          key         : key
          level       : activity_Schema.level          || 0
          name        : activity_Schema.name           || ''
          description : schema_Details?.description    || ''
          objective   : schema_Details?.objective      || ''
          proof       : schema_Details?.proof          || ''
          resources   : schema_Details?.resources      || []
          observed    : @.calculate_Observed(activity_Data)
          Yes         : activity_Data['Yes'  ]         || []
          No          : activity_Data['No'   ]         || []
          Maybe       : activity_Data['Maybe']         || []
          NA          : activity_Data['NA'   ]         || []


      @.observed[domain] =
        title: domain,                          # domain title
        index: index++,                         # for color coding
        activities: domain_Activities           # mapped activities in domain
    @

  proofs_For_Activity: (activity, callback)=>
    @.API.teams_Proofs @.project_Data?.project, (proofs)=>
      callback proofs[activity?.key]


app.service 'observed', ($routeParams,API, project_Data)=>
  return new Observed $routeParams, API, project_Data