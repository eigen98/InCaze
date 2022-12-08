//
//  Room.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation
struct Room : Codable{
    var id : String
    var title : String
    var contents : String
    var userId : String
    var limitMember : Int
    var memberCount : Int
    var partyIds : [Int]
}
