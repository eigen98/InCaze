//
//  BasicRunnerView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI
import Lottie


struct BasicRunnerView: View {
    var body: some View {
        
        VStack{
            LottieView(jsonName: "BasicRunner")
              
                .frame(width: 120, height: 120)
        }
        .onAppear{
           
        }
        
       
    }
}

struct BasicRunnerView_Previews: PreviewProvider {
    static var previews: some View {
        BasicRunnerView()
    }
}
