//
//  AuthService.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation


protocol AuthService {
    func initialize()
    func handleRedirectURL(redirectURL:URL)
    
    func isAuthenticated()
    func authenticate()
}

enum AuthError : Error {
    case success
    case fail
}

enum AuthType : String{
    case none = "none"
    case kakao = "kakao"
    case apple = "apple"
    case google = "google"
}

enum AuthState {
    case unauthenticated
    case authenticated
}

enum LoginState{
    case logout
    case login
    case unregistered
}
