//
//  DatabaseReference+ToAnyPublisher.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/21.
//

import Foundation
import FirebaseDatabase
import Combine
import Firebase
// most of the time you will need to do this multiple times in a project. Let’s see how we can write a simple extension to do this.
//Here, we have used Generics to allow callers to get any type of data from the reference.
//Let’s see what changes we will need to do in our ViewModel to use this extension.
extension DatabaseReference {
    func toAnyPublisher<T>() -> AnyPublisher<T?, Never> {
        let subject = CurrentValueSubject<T?, Never>(nil)

        let handle = observe(.value, with: { snapshot in
            subject.send(snapshot.value as? T)
        })
        
        return subject.handleEvents(receiveCancel: {[weak self] in
            self?.removeObserver(withHandle: handle)
        }).eraseToAnyPublisher()
    }
}

//example
 public class UserViewModel: ObservableObject {

     @Published var name: String = ""

     private var cancelables = Set<AnyCancellable>()
     private let db: DatabaseReference

     public init() {
         db = Database.database().reference()
         observeName()
     }

     private func observeName() {
         db.child("users").child("user_id").child("name")
             .toAnyPublisher()
             .sink { [weak self] (name: String?) in
                 if let name, let self {
                     self.name = name
                 }
             }.store(in: &cancelables)
     }
 }
 

