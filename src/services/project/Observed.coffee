app = angular.module('MM_Graph')

class Observed
  constructor: ($routeParams, project_Data)->
    @.$routeParams   = $routeParams
    @.project_Data   = project_Data
    @.domains        = null
    @.observed       = null
    @.observed_By_Id = null
    @.schema         = null


  current_Level: ()=>
    @.$routeParams.level || null

  filter_By_Level: (level)=>
    #for
    console.log 'asd'

# this returns the data in an sorted way, which I don't think is easier to read
#  get_Observed_By_Id: ()=>
#    observed_By_Id = {}
#    for domain_Name, domain_Data of @.observed
#      for key, activity of domain_Data.activities
#        observed_By_Id[key] = activity
#
#    result = []                                   # sort data by id
#    for key in observed_By_Id.keys().sort()
#      result.push observed_By_Id[key]
#
#    console.log result
#
#    return result

  map_Data: ()=>
    @.map_Domains()
     .map_Observed()
     .map_Observed_By_Id()

  map_Domains: ()=>
    schema = @.project_Data.schema
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

        domain_Activities[key]=
          title   : key
          level   : activity_Schema.level
          name    : activity_Schema.name
          observed: activity_Data['Yes']?.length ? 0
          Yes     : activity_Data['Yes']
          No      : activity_Data['No']
          Maybe   : activity_Data['Maybe']
          NA      : activity_Data['NA']


      @.observed[domain] =
        title: domain,                          # domain title
        index: index++,                         # for color coding
        activities: domain_Activities           # mapped activities in domain
    @

  map_Observed_By_Id: ()=>
    @.observed_By_Id = []
    for domain_Name, domain_Data of @.observed
      for key, activity of domain_Data.activities
        @.observed_By_Id.push activity
    @

#    for activity, activities of project_Activities
#      schema_Activity = schema.activities[activity]
#      if (not @.current_Level()) or schema_Activity?.level is @.current_Level()
#        project_Activities[activity] =
#          title: activity
#          level: schema_Activity?.level
#          name : schema_Activity?.name
#          activities: activities
#          observed: activities['Yes']?.length ? 0
    @


app.service 'observed', ($routeParams, project_Data)=>
  return new Observed $routeParams, project_Data