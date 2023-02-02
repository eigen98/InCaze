//
//  TabbarView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI

struct TabbarView: View {
    var body: some View {
        TabView{
            
            DependencyManager.shared.resolve(CrewListView.self)
            
            HomeView()
                .tabItem{
                    Image(systemName: "list.star")
                    Text("홈화면")
                }
            
            MyPageView()
                .tabItem{
                    Image(systemName: "person.fill")
                    Text("My")
                }
            
            
        }
        .onAppear{
            HealthDataRepository.shared.requestAuthorization()
        }
    }
}

struct TabbarView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarView()
    }
}
