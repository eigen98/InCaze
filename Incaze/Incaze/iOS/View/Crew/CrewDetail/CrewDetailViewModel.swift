//
//  CrewDetailViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine
//크루 상세 화면
class CrewDetailViewModel : ObservableObject{
    
    private var bag = Set<AnyCancellable>()
    
    var crewPublisher = PassthroughSubject<CrewModel, Never>()
    var isDeleted = CurrentValueSubject<Bool, Never>(false)
    @Published var crew : CrewModel? = nil
    
    
    
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
            }, receiveValue: {[weak self] value in
                if let value = value{
                    self?.crew = value
                    self?.crewPublisher.send(value)
                    
                    print("value : \(value)")
                }
               
               
            }).store(in: &bag)
        
    }
    
    func requestJoin(){
        //미가입 상태
        
        service.requestJoinCrew(crewId: crewId, myInfo: UserManager.getMe())
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Fetch posts failed: \(error)")
                    
                }
                    
            }, receiveValue: {[weak self] user in
                print("요청 완료")
                
            })
            .store(in: &bag)
    }
    
    func deleteMyCrew(){
        service.deleteMyCrew(crewId: crewId)
            .sink(receiveCompletion: {completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Fetch posts failed: \(error)")
                    
                }
                    
            }, receiveValue: {[weak self] result in
                print("삭제 완료")
                self?.isDeleted.send(true)
            })
            .store(in: &bag)
    }
    
    func buttonClosure(){
        var me = UserManager.getMe()
        //내가 만든 크루인경우
        if me.id == crew?.leaderId ?? ""{
            deleteMyCrew()
        }
        //가입한 크루가 없는 경우.
        else if me.crewId?.count == 0 || me.crewId == nil{
            //승인이 필요한 경우
            requestJoin()
            //바로 가입 가능한 경우
            
        }
        //이미 크루에 가입한 경우 X
        
        
        
    }
}
