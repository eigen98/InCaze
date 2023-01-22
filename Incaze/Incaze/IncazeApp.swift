//
//  IncazeApp.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI
import FirebaseCore
import Firebase
import GoogleSignIn
/*
 Firebase 초기화
 */
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

      print("firebase init")
      FirebaseApp.configure()
//      GIDSignIn.sharedInstance = FirebaseApp.app()?.options.clientID
//      GIDSignIn.sharedInstance.delegate = self
      return true
  }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any])
      -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}


@main
struct IncazeApp: App {// 앱 수명 주기 관리를 위한 AppDelegate와 SceneDelegate를 대체하는 App 프로토콜
    
    //DI
     //DependencyManager.shared.registerDependencies()
    
    @StateObject var loginViewModel = LoginViewModel()
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
            .environmentObject(loginViewModel)
            //RunTrackingView(now: .constant(CGPoint()))
           // ClientQuizView()
            //TrainAnimationView()
                
        }
    }
}
