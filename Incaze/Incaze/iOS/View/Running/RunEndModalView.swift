//
//  RunEndModalView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI

struct RunEndModalView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack{
            VStack {
                Text("경기 종료").font(.system(size: 26, weight: .bold)).foregroundColor(.black)
                
                Text("").font(.system(size: 20, weight: .medium)).foregroundColor(.black)
                
                HStack{
                 
                    // 로그아웃 버튼
                    Button(action: {
                        
                        presentation.wrappedValue.dismiss()
                    }) {
                        Text("닫기")
                            .font(.title3)
                        
                    }
                    .frame(width: 80, height: 40, alignment: .center)
                    .font(.system(size: 20 ,weight: .bold))
                    .foregroundColor(.white)
                    .background(.yellow)
                    .cornerRadius(12, corners: .allCorners)
                    
                }
               
                //.foregroundColor(Color.black)
            }.frame(width: 300,height: 200)
                .background(.white)
                .cornerRadius(12, corners: .allCorners)
               
                
        }.background(.clear)
    }
}

struct RunEndModalView_Previews: PreviewProvider {
    static var previews: some View {
        RunEndModalView()
    }
}

