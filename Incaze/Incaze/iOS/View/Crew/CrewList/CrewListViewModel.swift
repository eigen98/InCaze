//
//  CrewListViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine
class CrewListViewModel : ObservableObject{
    
    private var bag = Set<AnyCancellable>()
    var service : CrewService
    
    init(service: CrewService) {
        self.service = service
    }
    
    @Published var searchText : String = ""
    @Published var crewList : [CrewModel] = [ ]
    //CrewModel(id: "", crewName: "런린이만 기기링", leaderId: "ko_su", type: "모집중", users: [], limitMember: 20, memberCount: 5, minimumGrade: "Newbie", missionCondition: "없음")
    
    func getCrewList(){
        print("getCrewList()")
        service.getCrewList()
            .sink(receiveCompletion: {observer in
                switch observer {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
        }, receiveValue: {value in
            print("getCrewList Result :\(value)")
            self.crewList = value
            
        }) .store(in: &bag)
    }
        
                
    
    func createNewCrew(name: String, type : String, maxCount : Int, minimumGrade : String ){
        
        var myId = UserManager.shared.id
        var myEmail = UserManager.shared.email
        
        var me = User(id: myId,
                      email: myEmail,
                      status: 0,
                      nickname: "nickName",
                      createdAt: "",
                      updatedAt: "",
                      isSelectable: false)
        
        var newCrew = CrewModel(id: "myId_\(name)",
                                crewName: "\(name)",
                                leaderId: myId,
                                type: "type",
                                users: [me],
                                limitMember: maxCount,
                                memberCount: 1,
                                minimumGrade: minimumGrade,
                                missionCondition: "없음")
        
        service.createCrew(crew: newCrew)
            .sink(receiveCompletion: {observer in
                switch observer {
                case .failure(let error):
                    print(error)
                    return
                case .finished:
                    return
                }
            }, receiveValue: {value in
                print("createCrew Result :\(value)")
                
            })
            .store(in: &bag)
    }
}
