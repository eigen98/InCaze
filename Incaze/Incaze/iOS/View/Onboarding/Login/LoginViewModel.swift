//
//  LoginViewModel.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import Foundation
import Firebase
import GoogleSignIn

class LoginViewModel : ObservableObject {
    
    @Published var state : LoginState = .logout
    
    func signIn(){
        if GIDSignIn.sharedInstance.hasPreviousSignIn(){
            GIDSignIn.sharedInstance.restorePreviousSignIn{[unowned self] user, error in
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
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
           if let error = error {
             print(error.localizedDescription)
           } else {
               self.state = .login
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
