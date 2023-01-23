//
//  MyPageView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI

struct MyPageView: View {
    let characters:[String] = ["BasicRunner", "SpaceMan"]
    
    var deviceWidth = UserManager.shared.deviceWidth
    @State var offset : CGFloat = .init(0)
    var body: some View {
        
        ScrollView(.vertical){
            
            VStack{
                
                //캐릭터 선택
                
                PagingTabView(offset: $offset, content: {
                    var _ = print(offset)
                        HStack(spacing: 0) {
                            ForEach(characters.indices) { index in
                                ZStack{
                                    //이미지
                                    HStack{
                                        Color.white
                                    }.frame(width: deviceWidth,
                                            height: deviceWidth)
                                    
                                    
                                    
                                    //텍스트
                                    VStack{
                                        LottieView(jsonName: characters[index])
                                        Text("Number\(index)")
                                            .font(.system(size: 30,
                                                          weight: .bold
                                                         ))
                                        Text("Number2")
                                    }
                                }
                                
                                
                            }
                            .frame(width: deviceWidth, height: deviceWidth)
                        }
                    
                }).frame(width: deviceWidth, height: deviceWidth)
                
                HStack(spacing: 14){
                    ForEach(characters.indices, id : \.self){ index in
                        Capsule()
                            .fill(.gray)
                            .frame(width: getIndex() == index ? 20 :  7, height: 7)
                            
                    }
                }
                .overlay(
                    Capsule()
                        .fill(.gray)
                        .frame(width:  20, height: 7)
                        .offset(x: getIndicatorOffset())
                    ,alignment: .leading
                )
                //내 정보
                VStack{
                    
                }
             
            }
        }
        
    }
    
    func getIndicatorOffset() -> CGFloat{
        let progress = offset / deviceWidth
        
        let maxWidth : CGFloat = 12 + 7
        return progress * maxWidth
    }
    
    func getIndex() -> Int{
        let progress = offset / deviceWidth
        
        return Int(progress)
        
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
