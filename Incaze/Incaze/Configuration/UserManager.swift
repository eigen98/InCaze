//
//  UserManager.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/08.
//

import Foundation

import KeychainSwift
import UIKit

//유저 정보 관리 클래스
class UserManager {
    static let shared = UserManager()
    var deviceWidth = UIScreen.main.bounds.width

    static func getMe() -> User{
        return User(id: self.shared.id,
                    email: shared.email,
                    status: 0,
                    nickname: shared.nickname ?? "",
                    createdAt: shared.createdAt,
                    updatedAt: shared.updatedAt,
                    isSelectable: shared.isSelectable,
                    crewId: shared.crewId
        )
    }
    
    
    var jwt: String {
        get {
            return KeychainSwift().get("jwt") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "jwt")
        }
    }
    
    var email: String {
        get {
            return KeychainSwift().get("email") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "email")
        }
    }
    
    var crewId: String {
        get {
            return KeychainSwift().get("crewId") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "crewId")
        }
    }
    
    var id: String {
        get {
            return KeychainSwift().get("id") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "id")
        }
    }
    
    var image: String {
        get {
            return KeychainSwift().get("image") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "image")
        }
    }
    
    var createdAt: String {
        get {
            return KeychainSwift().get("createdAt") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "createdAt")
        }
    }
    
    var updatedAt: String {
        get {
            return KeychainSwift().get("updated") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "updated")
        }
    }
    
    var isSelectable: Bool {
        
        get {
            return UserDefaults.standard.bool(forKey: "isSelectable") ?? false//KeychainSwift().get("fullLocation") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "isSelectable") //KeychainSwift().set(newValue, forKey: "fullLocation")
        }
        
    }
    //Health 관련
    var weight: Double {
        
        get {
            return UserDefaults.standard.double(forKey: "weight") ?? 0.0//KeychainSwift().get("fullLocation") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "weight") //KeychainSwift().set(newValue, forKey: "fullLocation")
        }
        
    }
    
    //Health 관련
    var height: Double {
        
        get {
            return UserDefaults.standard.double(forKey: "height") ?? 0.0//KeychainSwift().get("fullLocation") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "height") //KeychainSwift().set(newValue, forKey: "fullLocation")
        }
        
    }
    
    //Health 관련
    var age: Int {
        
        get {
            return UserDefaults.standard.integer(forKey: "age") ?? 0//KeychainSwift().get("fullLocation") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "age") //KeychainSwift().set(newValue, forKey: "fullLocation")
        }
        
    }
    
    
    
    /*
     email database id 형식으로 변환
     */
    func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
    
    var mode : String {// V (Visitor) / M (Member)
        get {
            return KeychainSwift().get("mode") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "mode")
        }
    }
    
    
    var fullLocation: String { // 동네 이름 전체 (ex. 서울 동작구 노량진1동)
        get {
            return UserDefaults.standard.string(forKey: "fullLocation") ?? ""//KeychainSwift().get("fullLocation") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "fullLocation") //KeychainSwift().set(newValue, forKey: "fullLocation")
        }
    }
   
    
    // 탭바 높이 저장하는 변수
    var tabbarHeight: CGFloat?
    
    // 회원가입 api에 사용되는 변수
//    var provider: String = "" // 카카오, 애플 (로그인 플랫폼)
    var provider : String? {
       get {
           return KeychainSwift().get("provider") ?? ""
       }
       set {
           KeychainSwift().set(newValue ?? "", forKey: "provider")
       }
   }
  
    
    var accessToken: String { // 액세스 토큰
        get {
            return KeychainSwift().get("accessToken") ?? ""
        }
        set {
            KeychainSwift().set(newValue, forKey: "accessToken")
        }
    }
    var registerUser: Bool? // 사용자 정보 등록 여부
    var registerPet: Bool? // 반려견 등록 여부
    var registerLocation: Bool? // 동네위치 등록 여부
    var nickname: String? // 사용자 닉네임
    var phone: String? // 사용자 휴대폰
    var birthday: Int? // 사용자 생년월일
    var gender: String? // 사용자 성별
    var petName: String? // 반려견 이름
    var petType: String? // 견종
    var petBirthday: Int? // 반려견 생년월일
    var petGender: String? // 반려견 성별
    var petSize: Int? // 반려견 크기
    var termLocation: Bool? // 위치 정보 동의
   
    var term: Bool? // 회원가입 약관 동의
    var longitude: String { // 경도
        get {
            return UserDefaults.standard.string(forKey: "longitude") ?? ""//KeychainSwift().get("longitude") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "longitude") //KeychainSwift().set(newValue, forKey: "longitude")
        }
    }
    var longitudeTemp: String { // 동네 변경 중 경도
        get {
            return UserDefaults.standard.string(forKey: "longitudeTemp") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "longitudeTemp")
        }
    }
    
    var latitude: String { //  위도
        get {
            return  UserDefaults.standard.string(forKey: "latitude") ?? "" //KeychainSwift().get("latitude") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "latitude") //KeychainSwift().set(newValue, forKey: "latitude")
        }
    }
    
    var latitudeTemp : String { //  동네 변경 중 위도
        get {
            return  UserDefaults.standard.string(forKey: "latitudeTemp") ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "latitudeTemp")
        }
    }

    var accessNum : Int { // 접속 횟수 -> 마케팅 모달 띄우기
        get {
            return UserDefaults.standard.integer(forKey: "accessNum")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "accessNum")
        }
    }
   
    
//    var myQuizRecord : MyQuizRecord? {
//        get {
//            if let savedData = UserDefaults.standard.object(forKey: "myQuizRecord") as? Data {
//                let decoder = JSONDecoder()
//                if let savedObject = try? decoder.decode(MyQuizRecord.self, from: savedData) {
//                    return savedObject // Person(name: "jake", age: 20)
//                }
//            }
//            return nil
//        }
//        set {
//
//            let encoder = JSONEncoder()
//
//            // encoded는 Data형
//            if let encoded = try? encoder.encode(newValue) {
//                UserDefaults.standard.setValue(encoded, forKey: "myQuizRecord")
//            }
//            //UserDefaults.standard.set(newValue, forKey: "myQuizRecord")
//        }
//
//
//    }
//
   
    
    private init() {}
}
