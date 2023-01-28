//
//  CrewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/28.
//

import Foundation

import Foundation

//크루
struct CrewModel : Codable, Identifiable{
    var id : String
    var crewName : String
    var leaderId : String // 리더 아이디
    var type : String // 모집중, 모집마감
    var users : [User] //유저 리스트
    var limitMember : Int //최대 인원
    var memberCount : Int //최소 인원
    var minimumGrade : String //Newbie
    var mission : String?
    var missionLevel : Int?
    var missionCondition : String //없음, 매주, 매일, 3일마다, 격일마다
}
