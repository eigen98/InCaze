//
//  BoardListViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation
import FirebaseDatabase

class BoardListViewModel : ObservableObject {
    
    @Published var rooms : [Room] = []
    
    private lazy var databaseReference : DatabaseReference? = {
        let ref = Database.database().reference().child("Rooms")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func observeItemList(){
        rooms = []
        guard let databaseReference else{
            return
        }
        
        databaseReference
            .observe(.childAdded, with: {[weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String : Any]
                else {
                    return
                }
                
                json["id"] = snapshot.key
                do {
                    let data = try JSONSerialization.data(withJSONObject: json)
                    let room = try self.decoder.decode(Room.self, from: data)
                    print(room)
                    
                    self.rooms.insert(room, at: 0)
                }catch{
                    print("an error occurred", error)
                }
            })
        
        databaseReference
            .observe(.childChanged) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                
                json["id"] = snapshot.key
                
                do {
                    let data = try JSONSerialization.data(withJSONObject: json)
                    let room = try self.decoder.decode(Room.self, from: data)
                    print(room)
                    
                    var index = 0
                    for item in self.rooms {
                        if (room.id == item.id) {
                            print(item.id)
                            self.rooms.remove(at: index)
                        }
                        index += 1
                    }
                    
                    self.rooms.insert(room, at: 0)
                } catch {
                    print("an error occurred", error)
                }
        }
        
        databaseReference
            .observe(.childRemoved) {  [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                
                json["id"] = snapshot.key
                
                do {
                    let postitData = try JSONSerialization.data(withJSONObject: json)
                    let room = try self.decoder.decode(Room.self, from: postitData)
                    print(room)
                    
                    var index = 0
                    for roomItem in self.rooms {
                        if (room.id == roomItem.id) {
                            print(roomItem.id)
                            self.rooms.remove(at: index)
                        }
                        index += 1
                    }
                } catch {
                    print("an error occurred", error)
                }
            }
    }
    
    func createRoom(room : Room){
        databaseReference?.child(room.userId).setValue([
            "id": room.id,
            "title": room.title,
            "contents": room.contents,
            "userId": room.userId,
            "limitMember": room.limitMember,
            "memberCount": room.memberCount,
            "partyIds": room.partyIds
        ])
    }
    
}
