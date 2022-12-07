//
//  ContentView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI

struct ContentView: View {
    
    @State private var username = ""
    @State private var password = ""
    
    var body: some View {
        VStack {
                   TextField("Username", text: $username)
                       .padding()
                   SecureField("Password", text: $password)
                       .padding()
                   Button(action: login) {
                       Text("Login")
                   }
               }
    }
    
    func login() {
            // Perform login here
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
