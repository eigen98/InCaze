//
//  LoginViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation
import Firebase
import GoogleSignIn
import FirebaseDatabase

class LoginViewModel : ObservableObject {
    
    @Published var state : LoginState = .logout
    private var databaseRef: DatabaseReference!
    private var userRef: DatabaseReference!

    init() {
        databaseRef = Database.database().reference()
        userRef = databaseRef.child("User")
        
    }
    /*
     가입 여부 확인
     */
    public func userExists(with email: String,
                           completion: @escaping ((Bool)-> Void)) {
        var email = LoginViewModel.safeEmail(emailAddress: email)
        UserManager.shared.id = "\(LoginViewModel.safeEmail(emailAddress: email))"
        userRef.child(email).observeSingleEvent(of: .value) { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            
            completion(true)
            
        }
    }
    
    /*
     유저 추가
     */
    func addUser(email: String) {
        let date = Date()
        let userRef = userRef.child("\(LoginViewModel.safeEmail(emailAddress: email))")
        UserManager.shared.id = "\(LoginViewModel.safeEmail(emailAddress: email))"
        let newUser = [
            "id" : "\(LoginViewModel.safeEmail(emailAddress: email))",
            "email": email,
            "status" : UserStatus.VALID.rawValue,
            "nickname" : email,
            "createdAt" : "\(date)",
            "updatedAt" : "\(date)",
            "deletedAt" : "",
            "description" : "자기소개를 입력해주세요",
//            "pushToken" : "" //TODO: add FCM PushToken
            "point" : 0,
            "isHuman" : true
        ] as [String : Any]
        userRef.setValue(newUser)
    }
    /*
     email database id 형식으로 변환
     */
    static func safeEmail(emailAddress: String) -> String {
        var safeEmail = emailAddress.replacingOccurrences(of: "@", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
    
    /*
     구글 로그인
     */
    func signIn() {
      //
      if GIDSignIn.sharedInstance.hasPreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
            authenticateUser(for: user, with: error)
        }
      } else {
        //
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
        //
        let configuration = GIDConfiguration(clientID: clientID)
        
        //
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let rootViewController = windowScene.windows.first?.rootViewController else { return }
        
        // 5
        GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
          authenticateUser(for: user, with: error)
        }
      }
    }
    
    func authenticateUser(for user: GIDGoogleUser?, with error : Error?){
        if let error = error{
            print(error.localizedDescription)
            return
        }
    
        guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (result , error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                self.state = .login
                
                let email = GIDSignIn.sharedInstance.currentUser?.profile?.email ?? ""
                UserManager.shared.email = email
                UserManager.shared.image = "\(Auth.auth().currentUser?.photoURL ?? URL(string: ""))"
                //가입 여부 확인
                userExists(with: email , completion: { result in
                    if result {
                        print("가입 안 된 이메일")
                        //없으면 user 추가
                        self.addUser(email: email)
                      
                    }else{
                       
                        print("가입된 이메일")
                    }
                })
                
            }
        }
    }
    
    func signOut() {
      // 1
      GIDSignIn.sharedInstance.signOut()
      
      do {
        // 2
        try Auth.auth().signOut()
        
        state = .logout
      } catch {
        print(error.localizedDescription)
      }
    }
    
}
