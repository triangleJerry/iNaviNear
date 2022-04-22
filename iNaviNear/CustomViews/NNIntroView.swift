//
//  NNIntroView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/22.
//

import SwiftUI

struct NNIntroView: View {
    
    @Binding var startIntro: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // LottieView 사용자 파일명
                LottieView(startIntro: $startIntro, filename: "lottie_Intro")
                    .frame(width: 400, height: 400)
            }
            .navigationTitle("iNavi Near")
            .foregroundColor(Color(UIColor(red: 0.08, green: 0.38, blue: 0.76, alpha: 1.00)))
        }
        
    }
}

struct NNIntroView_Previews: PreviewProvider {
    static var previews: some View {
        NNIntroView(startIntro: .constant(true))
    }
}
