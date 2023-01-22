//
//  SearchTargetView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2022/12/29.
//

import SwiftUI
//타겟 이미지/버튼 뷰
struct SearchTargetView: View {
    var oppUser : User
    var image : String
//    var offset : CGSize
    let randomWidth = CGFloat.random(in: 100...200)
    let randomHeight = CGFloat.random(in: 100...400)
    
   // var playCompletion : (() -> ())
    @State var selected : Bool = false
    var body: some View {
        
            ZStack{
                AsyncImage(url: URL(string: image))
                   // .resizable()
                    //.aspectRatio(contentMode: .fill)
                    .frame(width: selected ? 100 : 50,
                           height: selected ? 100 : 50)
                    .clipShape(Circle())
                    .padding(4)
                    .background(Color.white.clipShape(Circle()))
                    
        //            .offset(CGSize(width: randomWidth,
        //                           height: randomHeight))
                    .shadow(radius: 8)
                    .onTapGesture(perform: {
                        animateSelect()
                        print("탭")
                    })
                
                VStack{
                   
                    
                    NavigationLink(destination: TwoPlayerRunningView(viewModel:
                                                                        RunningViewModel(oppUser: oppUser))){
                        Text("button")
                            .visibility(selected ? .visible : .gone)
                        
                    }
                    
                    
                    //                Button(action: {
                    //                    print("Play Button Click")
                    //
                    ////                    playCompletion()
                    //                }, label: {
                    //
                    //                    Image(systemName: "livephoto.play")
                    //                }).offset(CGSize(width: 30, height: 30))
                    //                .visibility(selected ? .visible : .gone)
                }
                
                
                
                
            }
            
        
        
            
    }
    
    func animateSelect(){
        if selected { return }
        withAnimation(Animation.linear(duration: 1)
        ){
            selected.toggle()
        }
        withAnimation(Animation.linear(duration: 1)
            .delay(5)
        ){
            selected.toggle()
        }
    }
}

struct SearchTargetView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTargetView(oppUser: User(id: "", email: "", status: 0, nickname: "", createdAt: "", updatedAt: ""), image: "")
    }
}

//How to Hide a SwiftUI View - Visible / Invisible / Gone
enum ViewVisibility: CaseIterable {
  case visible, // view is fully visible
       invisible, // view is hidden but takes up space
       gone // view is fully removed from the view hierarchy
}
extension View {
  @ViewBuilder func visibility(_ visibility: ViewVisibility) -> some View {
    if visibility != .gone {
      if visibility == .visible {
        self
      } else {
        hidden()
      }
    }
  }
}
