//
//  NNIntroView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/22.
//

import SwiftUI

struct NNIntroView: View {
    
    @Binding var startIntro: Bool
    @State var skipHidden: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 10) {
                // LottieView 사용자 파일명
                LottieView(startIntro: $startIntro, filename: "lottie_Intro")
                    .frame(width: 400, height: 400)
                
                Spacer()
                
                HStack {
                    Spacer()
                    SkipIntroButton(startIntro: $startIntro)
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 50, trailing: 50))
                        .opacity(skipHidden ? 1 : 0)
                }
            }
            .navigationTitle("iNavi Near")
            .foregroundColor(Color(UIColor(red: 0.08, green: 0.38, blue: 0.76, alpha: 1.00)))
        }
        .onTapGesture {
            skipHidden.toggle()
        }
        .onAppear { // 네비게이션 타이틀 색상 변경
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(red: 0.08, green: 0.38, blue: 0.76, alpha: 1.00)]
        }
        
    }
}

struct NNIntroView_Previews: PreviewProvider {
    static var previews: some View {
        NNIntroView(startIntro: .constant(true))
    }
}
