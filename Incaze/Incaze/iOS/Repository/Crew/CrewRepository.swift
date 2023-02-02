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
import FirebaseDatabase
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
    func getCrewListData() -> AnyPublisher<[CrewModel], CrewRepoError>
    
    //MARK: 가입 요청
    func requestJoinCrew(crewId : String, myInfo : User) -> AnyPublisher<User, CrewRepoError>
    //MARK: 가입 요청 메시지 조회
    func getRequestJoinMessages(crewId: String) -> AnyPublisher<[User], CrewRepoError>
    
    //MARK: 가입 요청 메시지 삭제(수락 & 거절 시 메시지 삭제)
    func deleteRequestJoinMessage(crewId: String, userId : String) -> AnyPublisher<String, CrewRepoError>
    
    //MARK: 크루 가입 (요청 승인 시 deleteRequestJoinMessage 호출 필요)
    func postNewUserCrewMember(crewId: String, user: User) -> AnyPublisher<User, CrewRepoError>
    //MARK: 유저 가입 크루 정보 추가.
    func addCrewOfUser(userId : String, crewId: String) -> AnyPublisher<String, CrewRepoError>
    //MARK: 크루 멤버 삭제
    func deleteUserCrewMember(crewId: String, user : User) -> AnyPublisher<String, CrewRepoError>
    
}

class CrewRepositoryImpl : CrewRepository{
    
    
    
    
    var db : Firestore
    private var databaseRef: DatabaseReference!
    init(){
        db = Firestore.firestore()
        databaseRef = Database.database().reference()
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
            self.db.collection("Crew").document(name)
                .getDocument(){snapshot, error in
                    
                    //이름 중복됨
                    if let snapshot, snapshot.exists{
                        observer(.success(false))
                    }else{
                        //이름 사용 가능
                        observer(.success(true))
                    }
                   
                }
            
        }.eraseToAnyPublisher()
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
            self.db.collection("Crew").document(crewId)
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
                        print("snapshot : \(snapshot.data())")
                        var crew = try snapshot.data(as: CrewModel.self)
                        print("crew : \(crew)")
                        observer(.success(crew))
                    }catch{
                        print("getCrewData Fail :")
                        print(error)
                        observer(.failure(CrewRepoError.failGetCrewData))
                    }
                    
                    
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
   
    //MARK: 가입 요청
    func requestJoinCrew(crewId : String, myInfo : User) -> AnyPublisher<User, CrewRepoError> {
        let dictionary = myInfo.asDictionary ?? ["crew" : "fail"]
        return Future<User, CrewRepoError>{observer in
            
            self.db.collection("CrewRequest").document(crewId)
                .collection("request").document("\(myInfo.id)")
                .setData(dictionary){error in
                    if error != nil{
                        observer(.failure(CrewRepoError.failUpdateCrewData))
                        return
                    }

                    observer(.success(myInfo))
                }
        }.eraseToAnyPublisher()
    }
    
    //MARK: 가입 요청 메시지 조회
    func getRequestJoinMessages(crewId: String) -> AnyPublisher<[User], CrewRepoError>{
        return Future<[User], CrewRepoError>{observer in
            self.db.collection("CrewRequest").document(crewId)
                .collection("request")
                .getDocuments{(snapshot, error) in
                    if let error = error{
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    
                    guard let snapshot = snapshot else{
                        observer(.failure(CrewRepoError.failGetCrewData))
                        return
                    }
                    
                    var requestList = [User]()
                    
                    snapshot.documents.forEach{doc in
                        do{
                            
                            var userRequest = try doc.data(as: User.self)
                            print("userRequest : \(userRequest)")
                            requestList.append(userRequest)
                        }catch{
                            print(error)
                        }
                        
                    }
                    print("requestList : \(requestList)")
                    observer(.success(requestList))
                    
                    
                    
                }
            
        }.eraseToAnyPublisher()
    }
    
    
    
    //MARK: 가입 요청 메시지 삭제(수락 & 거절 시 메시지 삭제)
    func deleteRequestJoinMessage(crewId: String, userId: String) -> AnyPublisher<String, CrewRepoError> {
        return Future<String, CrewRepoError>{observer in
            
            self.db.collection("CrewRequest").document(crewId).collection("request").document(userId).delete(){error in
                if let error = error{
                    print(error)
                    observer(.failure(CrewRepoError.failDeleteCrew))
                }
                observer(.success("가입 요청 메시지 처리상태 변경"))
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    //MARK: 크루 멤버추가 (요청 승인 시 deleteRequestJoinMessage 호출 필요)
    func postNewUserCrewMember(crewId: String,user: User) -> AnyPublisher<User, CrewRepoError> {
        return Future<User, CrewRepoError>{observer in
            self.db.collection("Crew").document(crewId)
                .updateData(["users" : FieldValue.arrayUnion([user])
                            ]){error in
                    if let error = error {
                        print(error)
                        observer(.failure(CrewRepoError.failDeleteCrew))
                        return
                    }
                    observer(.success(user))
                    
                }
            
            
        }.eraseToAnyPublisher()
    }
    
    //MARK: 크루 멤버 삭제
    func deleteUserCrewMember(crewId: String, user : User) -> AnyPublisher<String, CrewRepoError>{
        return Future<String, CrewRepoError>{observer in
            
            self.db.collection("Crew").document(crewId)
                .updateData(["users" : FieldValue.arrayRemove([user])]){error in
                if let error = error{
                    print(error)
                    observer(.failure(CrewRepoError.failDeleteCrew))
                }
                observer(.success("가입 요청 메시지 처리상태 변경"))
                
            }
        }
        .eraseToAnyPublisher()
    }
    //MARK: 유저의 크루 정보 삭제
    func deleteCrewOfUser(crewId: String, user : User) -> AnyPublisher<String, CrewRepoError> {
        return Future<String, CrewRepoError>{observer in
            
            self.databaseRef.child("User").child(user.id).child("crew").removeValue(){error, snapshot  in
                if let error = error{
                    print(error)
                    observer(.failure(CrewRepoError.failDeleteCrew))
                }
                observer(.success("크루 삭제"))
                
            }
        }
        .eraseToAnyPublisher()
    }
    

    //MARK: 유저 가입 크루 정보 추가.
    func addCrewOfUser(userId: String, crewId: String) -> AnyPublisher<String, CrewRepoError> {
        return Future<String, CrewRepoError>{observer in
            
            self.databaseRef.child("User").child(userId).child("crew").setValue(crewId){error, snapshot  in
                if let error = error{
                    print(error)
                    observer(.failure(CrewRepoError.failDeleteCrew))
                }
                observer(.success("크루 삭제"))
                
            }
        }
        .eraseToAnyPublisher()
    }
    
   

}
