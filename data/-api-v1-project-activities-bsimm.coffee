angular.module('MM_Graph').run ($httpBackend)-> $httpBackend.whenGET('/api/v1/project/activities/bsimm').respond {"SM.1.1":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"SM.1.2":{"No":["save-test","team-wtval","team-A","team-B"],"NA":["team-C"]},"SM.1.3":{"No":["save-test","team-wtval","team-B"],"NA":["team-A"],"Maybe":["team-C"]},"SM.1.4":{"No":["save-test","team-wtval"],"Maybe":["team-A"],"Yes":["team-B"],"NA":["team-C"]},"SM.2.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SM.2.2":{"No":["save-test","team-wtval","team-B","team-C"],"NA":["team-A"]},"SM.2.3":{"No":["save-test","team-wtval"],"Maybe":["team-A"],"Yes":["team-B","team-C"]},"SM.2.5":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SM.2.6":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SM.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SM.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CP.1.1":{"No":["save-test","team-wtval","team-C"],"Maybe":["team-A"],"Yes":["team-B"]},"CP.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"CP.1.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CP.2.1":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"CP.2.2":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-C"],"Yes":["team-B"]},"CP.2.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CP.2.4":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-C"],"Yes":["team-B"]},"CP.2.5":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-C"],"Yes":["team-B"]},"CP.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CP.3.2":{"No":["save-test","team-wtval","team-A","team-C"],"Yes":["team-B"]},"CP.3.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.1.1":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B"],"NA":["team-C"]},"T.1.5":{"No":["save-test","team-wtval","team-A","team-B"],"Maybe":["team-C"]},"T.1.6":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B"],"NA":["team-C"]},"T.1.7":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.2.5":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"T.2.6":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"T.2.7":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.3.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"T.3.4":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"T.3.5":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.1.1":{"No":["save-test","team-wtval","team-A","team-B"],"Yes":["team-C"]},"AM.1.2":{"No":["save-test","team-wtval","team-C"],"Maybe":["team-A","team-B"]},"AM.1.3":{"No":["save-test","team-wtval","team-A"],"Maybe":["team-B"],"NA":["team-C"]},"AM.1.4":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"AM.1.5":{"No":["save-test","team-wtval","team-A","team-B"],"NA":["team-C"]},"AM.1.6":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.2.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.2.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SFD.1.1":{"No":["save-test","team-wtval"],"NA":["team-A"],"Maybe":["team-B"],"Yes":["team-C"]},"SFD.1.2":{"No":["save-test","team-wtval","team-C"],"Maybe":["team-A","team-B"]},"SFD.2.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SFD.2.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SFD.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SFD.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SFD.3.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SR.1.1":{"No":["save-test","team-wtval","team-A"],"Maybe":["team-B"],"NA":["team-C"]},"SR.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"SR.1.3":{"No":["save-test","team-wtval","team-A"],"Maybe":["team-B","team-C"]},"SR.2.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SR.2.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SR.2.4":{"No":["save-test","team-wtval","team-B","team-C"],"NA":["team-A"]},"SR.2.5":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SR.2.6":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SR.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SR.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.1.1":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"AA.1.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.1.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.1.4":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"AA.2.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.2.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.2.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AA.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.1.1":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"CR.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"CR.1.4":{"No":["save-test","team-wtval","team-B","team-C"],"Yes":["team-A"]},"CR.1.5":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"CR.1.6":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.2.2":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"CR.2.5":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.2.6":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.3.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CR.3.4":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"ST.1.1":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"ST.1.3":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"ST.2.1":{"No":["save-test","team-wtval","team-B","team-C"],"Yes":["team-A"]},"ST.2.4":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"ST.2.5":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"ST.2.6":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"ST.3.3":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"ST.3.4":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"ST.3.5":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"PT.1.1":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"PT.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"PT.1.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"PT.2.2":{"No":["save-test","team-wtval"],"Yes":["team-A"],"Maybe":["team-B","team-C"]},"PT.2.3":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"PT.3.1":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"PT.3.2":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"SE.1.1":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SE.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"SE.2.2":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SE.2.4":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SE.3.2":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"SE.3.3":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"CMVM.1.1":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.1.2":{"No":["save-test","team-wtval"],"Yes":["team-A","team-B","team-C"]},"CMVM.2.1":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.2.2":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.2.3":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.3.1":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.3.2":{"No":["save-test","team-wtval"],"Maybe":["team-A","team-B","team-C"]},"CMVM.3.3":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"CMVM.3.4":{"No":["save-test","team-wtval","team-A","team-B","team-C"]},"AM.1.2.1":{"NA":["team-A"],"Maybe":["team-B","team-C"]},"SDF1.1":{"No":["team-A"],"Maybe":["team-B","team-C"]},"SFD.1.2.1":{"NA":["team-A"],"Maybe":["team-B","team-C"]},"SR.2.4.1":{"Maybe":["team-A"],"No":["team-B","team-C"]},"ST.1.3.1":{"Yes":["team-A"],"Maybe":["team-B","team-C"]},"SE.1.1.1":{"Maybe":["team-A","team-B","team-C"]},"SE.1.1.2":{"Maybe":["team-A","team-B","team-C"]},"SE.1.4":{"Maybe":["team-A","team-B","team-C"]}}