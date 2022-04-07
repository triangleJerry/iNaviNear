//
//  PreViewDev.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import SwiftUI


/// 터미널을 열고 아래줄의 명령어를 입력하면 프리뷰가 가능한 디바이스의 리스트를 확인할 수 있습니다.
/// Terminal app:: xcrun simctl list devicetypes
/// https://developer.apple.com/documentation/swiftui/securefield/previewdevice(_:)
struct PreViewDev<V: View>: View {
    enum Device: String, CaseIterable { // 프리뷰에서 활용할 기기 목록 정의
        
        case iPhone_4s = "iPhone 4s"
        case iPhone_5 = "iPhone 5"
        case iPhone_5s = "iPhone 5s"
        case iPhone_6_Plus = "iPhone 6 Plus"
        case iPhone_6 = "iPhone 6"
        case iPhone_6s = "iPhone 6s"
        case iPhone_6s_Plus = "iPhone 6s Plus"
        case iPhone_SE_1st_generation = "iPhone SE (1st generation)"
        case iPhone_7 = "iPhone 7"
        case iPhone_7_Plus = "iPhone 7 Plus"
        case iPhone_8 = "iPhone 8"
        case iPhone_8_Plus = "iPhone 8 Plus"
        case iPhone_X = "iPhone X"
        case iPhone_Xs = "iPhone Xs"
        case iPhone_Xs_Max = "iPhone Xs Max"
        case iPhone_Xʀ = "iPhone Xʀ"
        case iPhone_11 = "iPhone 11"
        case iPhone_11_Pro = "iPhone 11 Pro"
        case iPhone_11_Pro_Max = "iPhone 11 Pro Max"
        case iPhone_12_mini = "iPhone 12 mini"
        case iPhone_12 = "iPhone 12"
        case iPhone_12_Pro = "iPhone 12 Pro"
        case iPhone_12_Pro_Max = "iPhone 12 Pro Max"
        case iPhone_13_mini = "iPhone 13 mini"
        case iPhone_13 = "iPhone 13"
        case iPhone_13_Pro = "iPhone 13 Pro"
        case iPhone_13_Pro_Max = "iPhone 13 Pro Max"
        case iPhone_SE_2nd_generation = "iPhone SE (2nd generation)"
        case iPhone_SE_3nd_generation = "iPhone SE (3nd generation)"
    }
    
    let source: V // 프리뷰에서 표현될 뷰
    var devices: [Device] = [.iPhone_13, .iPhone_8]
    var displayDarkMode: Bool = false // 다크모드 출력 여부 결정
    
    var body: some View {
        Group {
            ForEach(devices, id: \.self) { // 지정한 기기 목록 수만큼 반복
                if displayDarkMode {
                    self.previewSource(device: $0)
                        .preferredColorScheme(.dark)
                } else {
                    self.previewSource(device: $0)
                }
            }
        }
    }
    
    private func previewSource(device: Device) -> some View {
        source
            .previewDevice(PreviewDevice(rawValue: device.rawValue)) // 기기 형태
            .previewDisplayName(device.rawValue) // 프리뷰 컨테이너에 표시할 이름
    }
}

struct Preview_Previews: PreviewProvider {
    static var previews: some View {
        PreViewDev(source: Text("PreViewDev Test"))
    }
}
