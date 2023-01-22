//
//  SearchView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/26.
//

import SwiftUI
import Foundation

struct SearchView: View {
    
    @Environment(\.presentationMode) var presentationMode
    //Animation Parameters...
    @State var startAnimation = false
    @State var pulse1 = false
    @State var pulse2 = false
    @ObservedObject var viewModel : SearchViewModel
    
    //Found People...
    //Max People will be 5
    //remaining all showing in bottomsheet
    
//    @State var foundPeople : [People] = []
    
    @State var finishAnimation = false
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
    }
    
    
    var body: some View {
        NavigationView{
            VStack{
                //Nav Bar
                HStack(spacing: 10){
                    Button(action: {
                        //NavigationLink
                        presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22,weight: .semibold))
                            .foregroundColor(.black)
                    })
                    
                    Text(finishAnimation ? "\(viewModel.foundUser.count) people NearBy": "NearBy Search")
                        .font(.title2)
                        .fontWeight(.bold)
                        .animation(.none)
                    
                    Spacer()
                    Button(action: {
                        //findTarget()
                    }, label: {
                        
                        if finishAnimation{
                            Image(systemName: "arrow.clockwise")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                        }else{
                            Image(systemName: "plus")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.black)
                        }
                        
                    })
                }
                .padding()
                .padding(.top, getSafeArea().top)
                .background(Color.white)
                
               Spacer()
                
                ZStack{
                    Circle()
                        .stroke(Color.gray.opacity(0.6))
                        .frame(width: 130, height: 130)
                        .scaleEffect(pulse1 ? 3.3 : 0)
                        .opacity(pulse1 ? 0 : 1)
                    
                    Circle()
                        .stroke(Color.gray.opacity(0.6))
                        .frame(width: 130, height: 130)
                        .scaleEffect(pulse2 ? 3.3 : 0)
                        .opacity(pulse2 ? 0 : 1)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 130, height: 130)
                        .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y: 5)
                    
                    ZStack{
                        Circle()
                            .stroke(Color.blue, lineWidth: 1.4)
                            .frame(width: finishAnimation ? 70 : 30, height: finishAnimation ? 70 : 30)
                            .overlay(
                                Image(systemName: "checkmark")
                                    .font(.largeTitle)
                                    .foregroundColor(.green)
                                    .opacity(finishAnimation ? 1 : 0)
                            
                            )
                        
                        ZStack{
                            Circle()
                                .trim(from: 0, to: 0.3)
                                .stroke(Color.blue, lineWidth: 2)
                            
                            Circle()
                                .trim(from: 0, to: 0.3)
                                .stroke(Color.blue, lineWidth: 2)
                                .rotationEffect(.init(degrees:  -180 ))
                            
                        }
                        
                    }
                    .frame(width: 70, height: 70)
                    .rotationEffect(.init(radians: startAnimation ? 360 : 0))
                    
                    if viewModel.isSelectable {
                        var _ = print("\(viewModel.isSelectable)")
                        if viewModel.foundUser.count >= 1{
                            SearchTargetView(oppUser: viewModel.foundUser[0], image: "\(viewModel.foundUser[0].image)")
                                .position(x: 150, y: 150)
                                
                        }
                        if viewModel.foundUser.count >= 2{
                            SearchTargetView(oppUser: viewModel.foundUser[0], image: "\(viewModel.foundUser[0].image)")
                                .position(x: 280, y: 150)
                        }
                        if viewModel.foundUser.count == 3{
                            SearchTargetView(oppUser: viewModel.foundUser[0], image: "\(viewModel.foundUser[0].image)")
                                .position(x: 150, y: 200)
                        }
                        if viewModel.foundUser.count == 4{
                            SearchTargetView(oppUser: viewModel.foundUser[0], image: "\(viewModel.foundUser[0].image)")
                                .position(x: 200, y: 200)
                        }
                    }
                    
                    
                    
                    
                    
                }
                .frame(maxHeight: .infinity)
                
                if finishAnimation{
                    //Bottom Sheet
                    VStack {
                        
                        //Pull up indicator
                        Capsule()
                            .fill(Color.gray.opacity(0.7))
                            .frame(width: 50,height: 4)
                            .padding(.vertical, 10)
                        
                        
                        ScrollView(.horizontal, showsIndicators: true, content: {
                            HStack(spacing: 15) {
                                
                                
                                ForEach(peoples){ people in
                                    VStack(spacing: 15){
                                        Image(people.image)
                                            .resizable()
                                            .aspectRatio( contentMode: .fill)
                                            .frame(width: 100, height: 100)
                                            .clipShape(Circle())
                                        
                                        Text(people.name)
                                            .font(.title2)
                                            .fontWeight(.bold)
                                        
                                        Button(action: {
                                            
                                        }, label: {
                                            Text("Choose")
                                                .fontWeight(.semibold)
                                                .padding(.vertical, 10 )
                                                .padding(.horizontal, 40)
                                                .background(Color.blue)
                                                .foregroundColor(.blue)
                                                .cornerRadius(10)
                                        })
                                    }
                                    .padding(.horizontal)
                                }
                            }
                            .padding()
                            .padding(.bottom, getSafeArea().bottom)
                        })
                    }
                    .background(Color.white)
                    .cornerRadius(25)
                    //bottom slide
                    .transition(.move(edge: .bottom))
                }
                
               
              
               Spacer()
                
                
            }
            .ignoresSafeArea()
            .background(Color.black.opacity(0.05).ignoresSafeArea())
            .onAppear(perform: {
                if viewModel.isSelectable{
                    viewModel.searchUser()
                }else{
                    
                    viewModel.startUnselectableUser()
                    
                    
                    
                }
                
               
                animationView()
                
            })
            
            
        }.navigationBarBackButtonHidden()
        
        
    }
//    func findTarget(user: User){
//        if $viewModel.foundUser.count < 5{
//            //adding people
//            withAnimation{
//                var people = peoples[$viewModel.foundUser.count]
//                // setting custom offset for top five found people...
//                people.offset = firstFiveOffsets[viewModel.foundUser.count]
//                viewModel.foundUser.append(user)
//            }
//
//
//
//        }else{
//            withAnimation(Animation.linear(duration: 0.6)){
//                finishAnimation.toggle()
//
//                //resetting all animation...
//                startAnimation = false
//                pulse1 = false
//                pulse2 = false
//            }
//
//            // checking if animation finished...
//            // if so restting all...
//            if finishAnimation{
//                withAnimation{
//                    //foundPeople.removeAll()
//                    animationView()
//                }
//            }
//        }
//    }
    
    func animationView(){
        
        withAnimation(Animation.linear(duration: 2).repeatForever(autoreverses: false)){
            startAnimation.toggle()
        }
        // it will start next round 0.1
        withAnimation(Animation.linear(duration: 1.7).delay( -0.1).repeatForever(autoreverses: false)){
            pulse1.toggle()
        }
        
        // 2nd pulse Animation...
        //will start
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 , execute: {
            withAnimation(Animation.linear(duration: 1.7).delay(-0.1).repeatForever(autoreverses: false)){
                pulse2.toggle()
            }
        })
    }
    

}

extension View{
    func getSafeArea() -> UIEdgeInsets{
        return UIApplication.shared.windows.first?.safeAreaInsets ??
        UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView( viewModel: .init(isSelectable: false))
    }
}



