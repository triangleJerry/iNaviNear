//
//  LottieView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/22.
//

import Lottie
import SwiftUI
import UIKit

struct LottieView: UIViewRepresentable {
    
    typealias UIViewType = UIView
    
    @Binding var startIntro: Bool
    
    var filename: String
    
    func makeUIView(context: UIViewRepresentableContext<LottieView>) -> UIView {
        
        let view = UIView(frame: .zero)
        let animationView = AnimationView()
        animationView.animation = Animation.named(filename) // 사용자 애니메이션 파일명
        animationView.contentMode = .scaleAspectFit // 애니메이션 크기가 적절하게 조정될 수 있도록
        animationView.loopMode = .playOnce
        animationView.play()
        animationView.play { (status) in // 애니메이션 저장

            if status {

                // toggling view. . .
                withAnimation(.interactiveSpring(response: 0.7, dampingFraction: 0.8, blendDuration: 0.8)) {
                    startIntro.toggle()
                }
            }
        }
        
        // 컨테이너의 너비와 높이를 자동으로 지정할 수 있도록
        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)
        
        // 자동완성 기능
        NSLayoutConstraint.activate([
            // 레이아웃의 높이와 넓이의 제약
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor)
        ])
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<LottieView>) {
        // do nothing
    }
}
