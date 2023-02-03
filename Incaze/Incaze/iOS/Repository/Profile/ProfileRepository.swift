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

enum ProfileRepoError: Error{
    case notFoundProfile
}

protocol ProfileRepository {
    //MARK: 프로필 정보 불러오기
    func getUserProfileInfo(userId : String) -> AnyPublisher<User?, ProfileRepoError>
}

class ProfileRepositoryImpl : ProfileRepository{
   
    
    
    private var db : Firestore
    private var databaseRef: DatabaseReference!
    init(){
        db = Firestore.firestore()
        databaseRef = Database.database().reference()
    }
    
    
   
    //MARK: 프로필 정보 불러오기
    func getUserProfileInfo(userId: String) -> AnyPublisher<User?, ProfileRepoError> {
        var myId = UserManager.shared.id
        let decoder = JSONDecoder()
        return Future<User?, ProfileRepoError>{observer in
           
            self.databaseRef.child("User").child(myId).observeSingleEvent(of: .value, with: {snapshot in
//                guard let dict = snapshot.value as? [String:[String:Any]] else {
//                    print("실패")
//                    observer(.failure(ProfileRepoError.notFoundProfile))
//                    return
//                }
                print(snapshot)
                guard let dict = snapshot.value as? [String:Any] else {
                    print("실패")
                    observer(.failure(ProfileRepoError.notFoundProfile))
                    return
                }
                print("dict : \(dict)")
                
                
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: dict)
                    let user = try decoder.decode(User.self, from: data)
                    print(user)
                    observer(.success(user))
                }catch{
                    print("an error occurred", error)
                }
                observer(.failure(ProfileRepoError.notFoundProfile))
            })
                
            
        }.eraseToAnyPublisher()
    }
    
    
}
