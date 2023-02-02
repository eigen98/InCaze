//
//  CrewDetailViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine

class CrewDetailViewModel : ObservableObject{
    var users : [User] = [
        User(id: "ko_su", email: "ko_su", status: 0, nickname: "도도", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su1", email: "ko_su", status: 0, nickname: "구구", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su2", email: "ko_su", status: 0, nickname: "오레오", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su3", email: "ko_su", status: 0, nickname: "프링글스", createdAt: "", updatedAt: "", isSelectable: false),
        User(id: "ko_su4", email: "ko_su", status: 0, nickname: "도리토스", createdAt: "", updatedAt: "", isSelectable: false),
    
    ]
    
    var crewPublisher = PassthroughSubject<CrewModel, Never>()
    
    
    private var bag = Set<AnyCancellable>()
    var service : CrewService
    var crewId : String
    
    init(service: CrewService, crewId : String) {
        self.service = service
        self.crewId = crewId
    }
    
    func fetchCrewDetail(){
        print("fetchCrewDetail()")
        service.getCrewDetail(crewId: self.crewId)
            .sink(receiveCompletion: {result in
                print(result)
            }, receiveValue: { value in
                if let value = value{
                    self.crewPublisher.send(value)
                    print("value : \(value)")
                }
               
               
            }).store(in: &bag)
        
    }
}
