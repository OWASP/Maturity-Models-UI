class Test_Data
  constructor: ()->
    @.items = ['bsimm_Schema', 'team_A']
      
  bsimm_Schema:       
    "SM.1.1": { "level" :"1", "activity" : "Is there a formal SDL (Software Development Lifecycle) used?"                                   }
    "SM.1.4": { "level" :"1", "activity" : "Is there Continuous Integration (with SDL security hooks)?"                                     }
    "SM.2.2": { "level" :"3", "activity" : "Are there at least two deployment pipelines? (one with the ability to block the release)"       }
    "SM.2.3": { "level" :"1", "activity" : "Is there an Security Champion?"                                                                 }  
    "CP.1.1": { "level" :"2", "activity" : "Are there any regulatory or compliance drivers? (to do Security)"                               }
    "CP.1.2": { "level" :"1", "activity" : "Have Data protections obligations been identified?"                                             }      

  bsimm_Team:
    {
        "metadata":{"team":"Team BSIMM"},
        "activities": { 
            "Governance"    :{ "SM.1.1":"Yes","SM.1.4":"No","SM.2.3":"NA","CP.1.1":"Maybe","CP.1.2":"Yes","CP.2.1":"Yes","CP.2.2":"Maybe","CP.2.4":"Maybe","CP.2.5":"Maybe","CP.3.2":"No","CP.3.2.1":"Maybe","CP.3.2.2":"Maybe","T.1.1":"Maybe","T.1.2":"No","T.1.6":"Yes","T.1.7":"No","T.2.5":"Yes","T.2.6":"Yes","T.3.2":"No","T.3.4":"Maybe"},
            "Intelligence"  :{ "AM.1.2":"Maybe","AM.1.2.1":"Maybe","AM.1.3":"Maybe","AM.1.4":"Maybe","SDF1.1":"Maybe","SFD.1.1":"Maybe","SFD.1.2":"Maybe","SFD.1.2.1":"Maybe","SR.1.1":"Maybe","SR.1.2":"Maybe","SR.1.3":"Maybe","SR.2.4":"No","SR.2.4.1":"No","SR.2.6":"Maybe","SR.2.5":"Maybe"},
            "SSDL"          :{ "AA.1.1":"NA","AA.1.4":"Maybe","CR.1.1":"Maybe","CR.1.2":"Maybe","CR.1.5":"Maybe","CR.2.2":"Yes","ST.1.1":"Maybe","ST.1.3":"Maybe","ST.1.3.1":"Maybe","ST.2.1":"No","ST.2.3":"Maybe","ST.2.5":"Maybe","ST.2.6":"Maybe","ST.3.4":"Yes","ST.3.5":"Maybe"},
            "Deployment"    :{ "PT.1.1":"No","PT.1.2":"Maybe","PT.2.2":"Maybe","PT.2.3":"Maybe","SE.1.1":"Maybe","SE.1.1.1":"Maybe","SE.1.1.2":"Maybe","SE.1.2": "Yes","SE.1.4":"Maybe","SE.2.2":"Maybe","SE.2.4":"Maybe","SE.3.2":"Maybe","SE.3.3":"Yes","CMVM.1.1":"Maybe","CMVM.1.2":"Yes","CMVM.2.1":"Maybe","CMVM.2.2":"Maybe","CMVM.2.3":"Maybe","CMVM.3.1":"Maybe","CMVM.3.2":"Maybe"}
        }
    }
  
  samm_Team:
    {
        "metadata":{"team":"Team SAMM"},
        "activities":{
          "Governance":{"SM.1.A":"Yes","SM.1.B":"No","SM.1.C":"NA","SM.2.A":"Maybe","SM.2.B":"No","SM.2.C":"No","SM.3.A":"Maybe","SM.3.B":"No","PC.1.A":"No","PC.1.B":"Yes","PC.2.A":"Yes","PC.2.B":"No","PC.3.A":"Maybe","PC.3.B":"No","EG.1.A":"Yes","EG.1.B":"No","EG.2.A":"Yes","EG.2.B":"No","EG.3.A":"Maybe","EG.3.B":"No"},
          "Construction":{"TA.1.A":"No","TA.1.B":"Yes","TA.2.A":"Yes","TA.2.B":"Yes","TA.2.C":"Yes","TA.3.A":"Yes","TA.3.B":"No","SR.1.A":"Yes","SR.1.B":"No","SR.2.A":"Maybe","SR.2.B":"NA","SR.3.A":"NA","SR.3.B":"No","SA.1.A":"Yes","SA.1.B":"Maybe","SA.2.A":"Yes","SA.2.B":"Maybe","SA.3.A":"Yes","SA.3.B":"No"},
          "Verification":{"DR.1.A":"Maybe","DR.1.B":"Yes","DR.2.A":"Maybe","DR.2.B":"NA","DR.3.A":"NA","DR.3.B":"No","IR.1.A":"Yes","IR.1.B":"Maybe","IR.2.A":"Yes","IR.2.B":"Yes","IR.3.A":"Yes","IR.3.B":"No","ST.1.A":"NA","ST.1.B":"Maybe","ST.1.C":"No","ST.2.A":"No","ST.2.B":"Yes","ST.3.A":"Maybe","ST.3.B":"Yes"},
          "Operation":{"IM.1.A":"Yes","IM.1.B":"Maybe","IM.1.C":"Yes","IM.2.B":"Yes","IM.2.C":"Maybe","IM.3.A":"NA","IM.3.B":"Maybe","EH.1.A":"Maybe","EH.1.B":"Maybe","EH.2.A":"NA","EH.2.B":"Maybe","EH.3.A":"Maybe","EH.3.B":"Yes","OE.1.A":"Yes","OE.1.B":"Yes","OE.2.A":"Yes","OE.2.B":"No","OE.3.A":"NA","OE.3.B":"Yes"}
        }
    }
  
app = angular.module('MM_Graph')
app.service 'test_Data', ()-> new Test_Data()