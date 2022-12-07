//
//  User.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation

enum UserStatus : Int{
    case VALID = 0
    case INVALID = 1
}
enum JoinPath : String{
    case KAKAO = "KAKAO"
    case APPLE = "APPLE"
    case GOOGLE = "GOOGLE"
}
enum gender{
    case MALE
    case FEMALE
}
enum MembershipStatus{
    case VALID
    case INVALID
}

//유저
struct User : Codable{
    var id : String
    var email : String
    var status : Int
    var nickname : String
    var createdAt : String
    var updatedAt : String
    var deletedAt : String?
    var description : String?
    var point : Int //win count
    var isHuman : Bool
    //    var pushToken : PushToken
//    var archive : Archive
    
    
}
