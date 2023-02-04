//
//  ProfileRepository.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/02.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseDatabase

enum UserInfoRepoError: Error{
    case notFoundProfile
    case failCreateChallengeResult
}

protocol UserInfoRepository {
    //MARK: 프로필 정보 불러오기
    func getUserProfileInfo(userId : String) -> AnyPublisher<User?, UserInfoRepoError>
    //MARK: 챌린지 결과 생성
    func postUserChallengeResult(result : RunningSession) -> AnyPublisher<RunningSession?, UserInfoRepoError>
}

class UserInfoRepositoryImpl : UserInfoRepository{
  
    
    
    
   
    
    
    private var db : Firestore
    private var databaseRef: DatabaseReference!
    init(){
        db = Firestore.firestore()
        databaseRef = Database.database().reference()
    }
    
    
   
    //MARK: 프로필 정보 불러오기
    func getUserProfileInfo(userId: String) -> AnyPublisher<User?, UserInfoRepoError> {
        var myId = UserManager.shared.id
        let decoder = JSONDecoder()
        return Future<User?, UserInfoRepoError>{observer in
           
            self.databaseRef.child("User").child(myId).observeSingleEvent(of: .value, with: {snapshot in
                
                guard let dict = snapshot.value as? [String:Any] else {
                    print("실패")
                    observer(.failure(UserInfoRepoError.notFoundProfile))
                    return
                }
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: dict)
                    let user = try decoder.decode(User.self, from: data)
                    print(user)
                    observer(.success(user))
                }catch{
                    print("an error occurred", error)
                }
                observer(.failure(UserInfoRepoError.notFoundProfile))
            })
                
            
        }.eraseToAnyPublisher()
    }
    
    
    //MARK: 챌린지 결과 생성
    func postUserChallengeResult(result : RunningSession) -> AnyPublisher<RunningSession?, UserInfoRepoError> {
        let dictionary = result.asDictionary ?? ["record" : "fail"]
        var myId = UserManager.shared.id
       
        var date = DateUtil.extractDate(from: result.date)
        var time = DateUtil.extractTime(from: result.date)
        
        return Future<RunningSession?, UserInfoRepoError>{ observer in
            self.db.collection("Record").document("\(myId)")
                .collection("\(date)").document("\(time)")
                .setData(dictionary){error in
                    if let error = error{
                        return observer(.failure(UserInfoRepoError.failCreateChallengeResult))
                        
                    }
                    return observer(.success(result))
                    
                }
        }.eraseToAnyPublisher()
    }
    
    
    
    
    
}
