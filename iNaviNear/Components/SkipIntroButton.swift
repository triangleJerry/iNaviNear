//
//  SkipIntroButton.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/25.
//

import SwiftUI

struct SkipIntroButton: View {
    
    @Binding var startIntro: Bool
    
    var body: some View {
        Button(action: {
            
            HapticManager.instance.impact(style: .heavy)
            startIntro.toggle()
            
        }) {
            Image(systemName: "chevron.right.2")
                .resizable()
                .scaledToFill()
                .frame(width: 55.0, height: 35.0)
                .clipped() // 프레임을 벗어나는 이미지 제거
                .padding(8)
        }
        .background(Color.white)
        .onTapGesture {
            
            let impactHeavy = UIImpactFeedbackGenerator(style: .heavy)
            impactHeavy.impactOccurred()
            
        }
    }
}

struct SkipIntroButton_Previews: PreviewProvider {
    static var previews: some View {
        SkipIntroButton(startIntro: .constant(false))
    }
}
