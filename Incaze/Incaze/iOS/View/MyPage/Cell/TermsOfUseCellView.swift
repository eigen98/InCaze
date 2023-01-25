//
//  TermsOfUseCellView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/24.
//

import SwiftUI

struct TermsOfUseCellView: View {
    var deviceWidth = UserManager.shared.deviceWidth
    var body: some View {
        
        ZStack{
            VStack{
                HStack{
                    Image(systemName: "newspaper.fill")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                       
                        
                    Text("Terms of use")
                        .foregroundColor(.white)
                        .font(.system(size: 20, weight: .bold))
                        
                }
            }
        }
        .frame(width: deviceWidth - 48 ,height: 70)
        .background(Color(red: 39/255, green: 38/255, blue: 70/255))
        .cornerRadius(22, corners: .allCorners)
        .overlay(RoundedRectangle(cornerRadius: 22)
            .stroke(Color.init(red: 92/255, green:  92/255, blue:  119/255), lineWidth: 2)
              )
    }
}

struct TermsOfUseCellView_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfUseCellView()
    }
}
