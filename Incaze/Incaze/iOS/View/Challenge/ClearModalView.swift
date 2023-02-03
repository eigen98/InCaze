//
//  ClearModalView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/02/03.
//

import SwiftUI

struct ClearModalView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack{
            VStack {
                Text("실패").font(.system(size: 28, weight: .bold)).foregroundColor(.red)
                
                Text("시간이 초과되었습니다ㅠㅠ").font(.system(size: 22, weight: .bold)).foregroundColor(.black)
                
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

struct ClearModalView_Previews: PreviewProvider {
    static var previews: some View {
        ClearModalView()
    }
}
