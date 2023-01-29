//
//  CrewRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

enum CrewRepoError: Error{
    case notFoundCrewData
    case failGetCrewData
    case failCreateNewCrew
    case failUpdateCrewData
    case failDeleteCrew
    
}

protocol CrewRepository{
    //MARK: 크루 생성
    func createCrew(crew : CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError>
    
    //TODO: 크루 중복 확인
    func doubleCheckCrewName(name : String) -> AnyPublisher<Bool, CrewRepoError>
    
    //MARK: 크루 상세 정보 조회
    func getCrewData(crewId : String) -> AnyPublisher<CrewModel?, CrewRepoError>
    //MARK: 크루 정보 업데이트
    func updateCrewData(crewId : String, editedCrew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError>
    //MARK: 크루 삭제
    func deleteCrew(crewId : String) -> AnyPublisher<String?, CrewRepoError>
    
    //TODO: 크루 리스트 조회
    func getCrewListData() -> AnyPublisher<[CrewModel], CrewRepoError >
    
    //TODO: 불가능한 경우
    
    //MARK: 가입 요청
    
    //MARK: 가입 요청 메시지 조회
    //MARK: 가입 요청 메시지 수락
    
    //MARK: 바로 가입
    
    //MARK: 크루 탈퇴
    //MARK: 크루 멤버 강퇴
}

class CrewRepositoryImpl : CrewRepository{
    
    
    
  
    
    
    
    var db : Firestore
    init(){
        db = Firestore.firestore()
    }
    
    
    
    /*
     //MARK: 크루 생성
     */
    func createCrew(crew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError> {
        let dictionary = crew.asDictionary ?? ["crew" : "fail"]
        return Future<CrewModel?, CrewRepoError>{ observer in
            self.db.collection("Crew").document("\(crew.crewName)")
                .setData(dictionary){error in
                    if let error = error{
                        return observer(.failure(CrewRepoError.failCreateNewCrew))
                        
                    }
                    return observer(.success(crew))
                    
                }
        }.eraseToAnyPublisher()
        
    }
    
    //MARK: 크루 이름 중복 확인
    func doubleCheckCrewName(name: String) -> AnyPublisher<Bool, CrewRepoError> {
        return Future<Bool, CrewRepoError>{observer in
            
        }
    }
    /*
     //MARK: 크루 리스트 조회
     */
    func getCrewListData() -> AnyPublisher<[CrewModel], CrewRepoError> {
        return Future<[CrewModel], CrewRepoError>{observer in
            self.db.collection("Crew")
                .getDocuments{(snapshot, error) in
                    if let error = error{
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    
                    guard let snapshot = snapshot else{
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    
                    var crewList = [CrewModel]()
                    
                    snapshot.documents.forEach{doc in
                        do{
                            
                            var crew = try doc.data(as: CrewModel.self)
                            print("crew : \(crew)")
                            crewList.append(crew)
                        }catch{
                            print(error)
                        }
                        
                    }
                    print("crewList : \(crewList)")
                    observer(.success(crewList))
                    
                    
                    
                }
            
        }.eraseToAnyPublisher()
    }
    
    //TODO: 크루 상세 정보 조회
    //CrewId 필요
    func getCrewData(crewId: String) -> AnyPublisher<CrewModel?, CrewRepoError> {
        return Future<CrewModel?, CrewRepoError>{observer in
            self.db.collection("Crew").document("")
                .getDocument{ snapshot, error in
                    if let error = error{
                        print(error)
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    
                    guard let snapshot = snapshot else{
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    var crew : CrewModel? = nil
                    do{
                        var crew = try snapshot.data(as: CrewModel.self)
                        
                    }catch{
                        print(error)
                        observer(.failure(CrewRepoError.failGetCrewData))
                    }
                    
                    observer(.success(crew))
                }
        }.eraseToAnyPublisher()
        
    }
    
    //MARK: 크루 정보 업데이트(크루 모집 상태, 미션 조건, 크루이름)
    func updateCrewData(crewId: String, editedCrew: CrewModel) -> AnyPublisher<CrewModel?, CrewRepoError> {
        let dictionary = editedCrew.asDictionary ?? ["crew" : "fail"]
        return Future<CrewModel?, CrewRepoError>{observer in
            self.db.collection("Crew")
                .document(crewId).setData(dictionary){error in
                    if error != nil{
                        observer(.failure(CrewRepoError.failUpdateCrewData))
                        return
                    }
                    
                    observer(.success(editedCrew))
                }
        }.eraseToAnyPublisher()
    }
    
    //MARK: 크루 삭제
    func deleteCrew(crewId: String) -> AnyPublisher<String?, CrewRepoError> {
        return Future<String?, CrewRepoError>{observer in
            
            self.db.collection("Crew").document(crewId).delete(){error in
                if let error = error{
                    print(error)
                    observer(.failure(CrewRepoError.failDeleteCrew))
                }
                observer(.success("크루를 삭제하였습니다."))
                
            }
        }
        .eraseToAnyPublisher()
    }
   
    
    
    
    
}
