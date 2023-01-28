//
//  TimesUpView.swift
//  Incaze
//
//  Created by JeongMin Ko on 2023/01/23.
//

import SwiftUI
import Lottie

struct TimesUpView: View {
    var body: some View {
        //위에서 Lottie는 우리 UIVIew로 변환된다고 했기 때문에,
        
        //다음과 같이 AnimationView라는 인스턴스를 생성해 실행할 JSON 파일 이름을 넣어주고,
        LottieView(jsonName: "TimesUp")
            .frame(width: 100, height: 100)
    
        
    }
}

struct TimesUpView_Previews: PreviewProvider {
    static var previews: some View {
        TimesUpView()
    }
}
