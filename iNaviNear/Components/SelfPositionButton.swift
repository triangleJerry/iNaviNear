//
//  SelfPositionButton.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/11.
//

import SwiftUI

struct SelfPositionButton: View {
    var body: some View {
        Button(action: {
            
        }) {
            Image(systemName: "scope")
                .resizable()
                .scaledToFill()
                .frame(width: 40.0, height: 40.0)
                .clipped() // 프레임을 벗어나는 이미지 제거
                .padding(8)
        }
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct SelfPositionButton_Previews: PreviewProvider {
    static var previews: some View {
        SelfPositionButton()
            .previewLayout(.fixed(width: 260, height: 220))
    }
}
