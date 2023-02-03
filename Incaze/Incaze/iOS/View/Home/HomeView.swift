//
//  HomeView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/07.
//

import SwiftUI

import SwiftUI
import GoogleSignIn
import MapKit
struct HomeView: View {
  // 1
  //@EnvironmentObject var viewModel: LoginViewModel
    var userState = true
    
    @State private var distance = 0.0
    @State private var pace = 0.0
    @State private var coordinates = [CLLocationCoordinate2D]()
    @State private var isPermissionPresented = false
    private var locationPermissions: LocationPermissions = LocationPermissions()
    
    var notificationView: some View {
        
        GeometryReader { geometry in
            Group {
                Button(action: {
                    UIApplication.shared.open(
                        URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil
                    )
                }) {
                    VStack {
                        Text("enable_location_title")
                            .font(.headline)
                            .foregroundColor(Color(UIColor.label))
                        Text("enable_location_details")
                            .font(.caption)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
            }
            .frame(width: geometry.size.width - 68*2, height: 70)
            .background(Color(UIColor.systemBackground))
            .transition(.slide)
            .offset(x: 68, y: 16)
        }
    }
    
    private let user = GIDSignIn.sharedInstance.currentUser
    
  var body: some View {
    NavigationView {
      VStack {
          Spacer()
          
          HStack(spacing: 24){
              
              VStack{
                  NavigationLink(destination: SearchView(viewModel: SearchViewModel(isSelectable: true)), label: {
                      Text("SearchMate")
                          .font(.system(size: 20,weight: .bold))
                          .foregroundColor(.white)
                          .frame(width: 120, height: 120)
                  })
                  .frame(width: 120, height: 120)

              }.background(.black)
                  .cornerRadius(20, corners: .allCorners)
              
              VStack{
                  NavigationLink(destination: ChallengeStageView(), label: {
                      Text("Challenge")
                          .font(.system(size: 20,weight: .bold))
                          .foregroundColor(.white)
                          .frame(width: 120, height: 120)
                  })
                  .frame(width: 120, height: 120)
               
              }.background(.black)
                  .cornerRadius(20, corners: .allCorners)
          }
          
          HStack(spacing: 24){
              
              VStack{
               Button(action: {
                   
               }, label: {
                   Text("Mission")
                       .font(.system(size: 20,weight: .bold))
                       .foregroundColor(.white)
               })
               .frame(width: 120, height: 120)
               
              }.background(.black)
                  .cornerRadius(20, corners: .allCorners)
              
              VStack{
               Button(action: {
                   
               }, label: {
                   Text("OK")
                       .font(.system(size: 20,weight: .bold))
                       .foregroundColor(.white)
               })
               .frame(width: 120, height: 120)
               
              }.background(.black)
                  .cornerRadius(20, corners: .allCorners)
          }
          
          
          
          if self.isPermissionPresented {
              self.notificationView
                  .transition(.slideInOut)
          }
          
          Spacer()
          
          VStack{
              if !userState {
                  FlipView()
              }else{
                  VStack {
                  }
              }
            
          }
        
        Spacer()
        
        // 4
        
      }
      .frame(width: 400)
      //.background(.blue)
      .background(Color.init(red: 30/255, green: 26/255, blue: 62/255))
      .navigationTitle(Text("InCaze").foregroundColor(.white))
      
      
    }
    .onAppear{
        setNavigationTitleColor()
    }
    .onReceive(locationPermissions.status) { status in
        switch status {
        case .denied, .restricted:
            withAnimation { self.isPermissionPresented = true }
        default:
            withAnimation { self.isPermissionPresented = false }
        }
    }
    
    .navigationViewStyle(StackNavigationViewStyle())
      
  }
    /*
     NavigationTitlecolor Setting
     */
    func setNavigationTitleColor(){
        let navBarAppearance = UINavigationBar.appearance()
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
}

/// A generic view that shows images from the network.
struct NetworkImage: View {
  let url: URL?

  var body: some View {
    if let url = url,
       let data = try? Data(contentsOf: url),
       let uiImage = UIImage(data: data) {
      Image(uiImage: uiImage)
        .resizable()
        .aspectRatio(contentMode: .fit)
    } else {
      Image(systemName: "person.circle.fill")
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
  }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(LoginViewModel())
    }
}

import Foundation
struct People : Identifiable{
    var id = UUID().uuidString
    var image: String
    var name: String
    //Offset will be used for showing user in pulse animation...
    var offset: CGSize = CGSize(width: 0, height: 0)
    
}

var peoples = [
    People( image: "eraser", name: "Eigen"),
    People( image: "square.and.pencil.circle.fill", name: "Sral"),
    People( image: "scribble", name: "Garosh"),
    People( image: "pencil.tip.crop.circle", name: "Arthas"),
    People( image: "pencil.tip.crop.circle", name: "Arthas")

]

var firstFiveOffsets : [CGSize] = [
    CGSize(width: 100, height: 100),
    CGSize(width: -100, height: -100),
    CGSize(width: -50, height: 130),
    CGSize(width: 50, height: -130),
    CGSize(width: 120, height: -50)
    

]
