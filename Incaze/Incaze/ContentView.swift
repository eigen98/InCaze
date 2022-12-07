//
//  ContentView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel : LoginViewModel
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        
            
        switch viewModel.state {
            case .login : HomeView()
            case .logout : LoginView()
            case .unregistered:
            LoginView()
        }
    }
    
    func login() {
        // Perform login here
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(LoginViewModel())
    }
}
