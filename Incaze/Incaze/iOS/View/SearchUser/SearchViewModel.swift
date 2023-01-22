//
//  SearchViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/02.
//

import Foundation
import Firebase
import FirebaseDatabase
import Combine

class SearchViewModel : ObservableObject {
    
    @Published var foundUser : [User] = [] //찾은 유저
    @Published var oppUser : User? = nil
    var cancellable = Set<AnyCancellable>()
    var observerCancellable : AnyCancellable?
    
    private let encoder = JSONEncoder() //create JsonForm
    private let decoder = JSONDecoder()
    
    private var databaseRef: DatabaseReference!
    private var searchUserRef: DatabaseReference!

    var randomWidth : [CGFloat] = [] //검색된 유저 띄워줄 포지션
    var randomHeight : [CGFloat] = [] //검색된 유저 띄워줄 포지션
    //상대방 선택 가능 여부
    var isSelectable = false
    
    init(isSelectable : Bool) {
        databaseRef = Database.database().reference()
        searchUserRef = databaseRef.child("Searching")
        self.isSelectable = isSelectable
    }
    
    /*
     매칭 중 유저 등록
     case : isSelectable = false
     */
    func addSearchList() async -> Void{
        let date = Date()
        let email = UserManager.shared.email
        let ref = searchUserRef.child("\(UserManager.shared.safeEmail(emailAddress: email))")
        UserManager.shared.id = "\(UserManager.shared.safeEmail(emailAddress: email))"
        let newUser = [
            "id" : "\(UserManager.shared.id)",
            "email": email,
            "status" : UserStatus.VALID.rawValue,
            "nickname" : email,
            "createdAt" : "\(date)",
            "updatedAt" : "\(date)",
            "deletedAt" : "",
            "image" :  UserManager.shared.image ?? "",
            "description" : "자기소개를 입력해주세요",
//            "pushToken" : "" //TODO: add FCM PushToken
            "point" : 0,
            "isHuman" : true
            
        ] as [String : Any]
        
        do{
           try await ref.setValue(newUser)
        }catch{
            
        }
        
        
        
        
        
    }
    /*
     유저 검색 시작 (상대 선택 불가 )
     */
    func startUnselectableUser(){
        Task{
            await addSearchList()
            
            await addSearchingQueue()
            
            var waitingStatus = await observeWaitingStatus()
            
            self.observerCancellable = waitingStatus.sink{[weak self] user in
                print("startUnselectableUser() \(user)")
                if user != nil{
                    
                    // Searching, SearchingQueue 제거 (직접 선택한 유저가 Running Channel 생성)
                    let email = UserManager.shared.email
                    let searchRef = self?.databaseRef.child("\(UserManager.shared.safeEmail(emailAddress: email))")
                    searchRef?.removeValue()
                    
                    let queueRef = self?.databaseRef.child("SearchingQueue").child("\(UserManager.shared.safeEmail(emailAddress: email))")
                    queueRef?.removeValue()
                    //user 매칭 시 observer 제거
                    print("startUnselectableUser() \(user)")
                    self?.observerCancellable?.cancel()
                    
                    
                }
             }
        }
    }
    
    /*
     검색 대기 큐 유저 추가.
     */
    func addSearchingQueue() async -> Void{
        let email = UserManager.shared.email
        let ref = databaseRef.child("SearchingQueue").child("\(UserManager.shared.safeEmail(emailAddress: email))")
        let waitingUser = ""
        do {
            try await ref.setValue(waitingUser)
        }catch{
            print("an error occurred : addSearchingQueue")
            print("an error occurred", error)
        }
        
        
    }
    
    //검색 대기 옵저빙
    func observeWaitingStatus() async -> AnyPublisher<User?, Never>{
        
        let email = UserManager.shared.email
        let ref = databaseRef.child("SearchingQueue").child("\(UserManager.shared.safeEmail(emailAddress: email))")
        
        // create a subject that will allow callers to observe data using Combine.
        let subject = CurrentValueSubject<User?, Never>(nil)
        
        // get the reference name from the database and observe its value change.
        let handle = ref.observe(.value, with: { snapshot in
            do{
                let data = try JSONSerialization.data(withJSONObject: snapshot)
                let user = try self.decoder.decode(User.self, from: data)
                //Whenever we get data, we pass it to subject .
                subject.send(snapshot.value as? User)
            
            }catch{
                print("an error occurred : observeWaitingStatus")
                print("an error occurred", error)
            }
        })
        
        // Detach handle on cancellation
        //At last, we add a listener in the subject to get notified when the publisher is canceled, this will make sure we don’t keep observing the database once the caller is done with it.
        return subject.handleEvents(receiveCancel: {[weak self] in
            self?.databaseRef.removeObserver(withHandle: handle)
            
        }).eraseToAnyPublisher()
    }
    
    
    
    /*
     유저 검색
     case : isSelectable = true
     */
    func searchUser(){
        
        searchUserRef.observeSingleEvent(of: .value, with: { snapshot in
            
            guard let dict = snapshot.value as? [String:[String:Any]] else {
                print("실패")
                return
            }
            Array(dict.values).forEach {
                do {
                    
                    let data = try JSONSerialization.data(withJSONObject: $0)
                    let user = try self.decoder.decode(User.self, from: data)
                    print(user)
                    
                    self.foundUser.insert(user, at: 0)
                    self.randomWidth.append(CGFloat.random(in: 100...200))
                    self.randomHeight.append(CGFloat.random(in: 100...200))
                    print("searching User: \(self.foundUser)")
                }catch{
                    print("an error occurred", error)
                }
                
            
                
            }
        })
        
//        searchUserRef
//            .observe(.childAdded, with: {[weak self] snapshot in
//                guard
//                    let self = self,
//                    var json = snapshot.value as? [String : Any]
//                else {
//                    return
//                }
//                
//                json["id"] = snapshot.key
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(User.self, from: data)
//                    print(user)
//                    
//                    self.foundUser.insert(user, at: 0)
//                    print("searching User: \(self.foundUser)")
//                }catch{
//                    print("an error occurred", error)
//                }
//                
//            })
//        
//        searchUserRef
//            .observe(.childChanged) { [weak self] snapshot,_  in
//                guard
//                    let self = self,
//                    var json = snapshot.value as? [String: Any]
//                else {
//                    return
//                }
//                
//                json["id"] = snapshot.key
//                
//                do {
//                    let data = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(User.self, from: data)
//                    print(user)
//                    
//                    var index = 0
//                    for item in self.foundUser {
//                        if (user.id == item.id) {
//                            print(item.id)
//                            self.foundUser.remove(at: index)
//                        }
//                        index += 1
//                    }
//                    
//                    self.foundUser.insert(user, at: 0)
//                } catch {
//                    print("an error occurred", error)
//                }
//        }
//        
//        searchUserRef
//            .observe(.childRemoved) {  [weak self] snapshot,_  in
//                guard
//                    let self = self,
//                    var json = snapshot.value as? [String: Any]
//                else {
//                    return
//                }
//
//                json["id"] = snapshot.key
//
//                do {
//                    let postitData = try JSONSerialization.data(withJSONObject: json)
//                    let user = try self.decoder.decode(User.self, from: postitData)
//                    print(user)
//
//                    var index = 0
//                    for user in self.foundUser {
//                        if (user.id == user.id) {
//                            print(user.id)
//                            self.foundUser.remove(at: index)
//                        }
//                        index += 1
//                    }
//                } catch {
//                    print("an error occurred", error)
//                }
//            }
       
        
        
    }
}


// import Combine
// import FirebaseFirestore
// import FirebaseFirestoreSwift
//
// struct BadgesService {
//     static let db = Firestore.firestore()
//     
//     static func fetchBadges() -> AnyPublisher<[Badge], Error> {
//         return Future<[Badge], Error> { promise in
//             self.db.collection("Badges")
//                 .getDocuments { (snapshot, error) in
//                     
//                     if let error = error {
//                         promise(.failure(error))
//                         return
//                     }
//                     
//                     print("BadgesService 시작")
//                     
//                     guard let snapshot = snapshot else {
//                         print("snapshot error")
//                         return
//                     }
//                     
//                     var items = [Badge]()
//                     snapshot.documents.forEach { document in
//                         if let item = try? document.data(as: Badge.self) {
//                             print("badge : \(item)")
//                             items.append(item)
//                         }
//                         
//                     }
//                     promise(.success(items))
//                     
//                 }
//         }
//         .eraseToAnyPublisher()
//     }
// }
// 
