//
//  NNSettingView.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import SwiftUI

struct NNSettingView: View {
    
    @State private var hapticToggle = UserDefaults.standard.bool(forKey: "haptic")
    @State private var markersToggle = UserDefaults.standard.bool(forKey: "markers")
    @State private var stepperAmount = UserDefaults.standard.integer(forKey: "area")
    
    @Binding var goIndex: Int
    
    var body: some View {
        List {
            Section(header: Text("Options")) {
                
                // 햅틱 진동
                Toggle(isOn: $hapticToggle, label: {
                    
                    HStack {
                        Image(systemName: "iphone.radiowaves.left.and.right")
                        Text("Haptic")
                    }
                }).onChange(of: hapticToggle) { value in
                    
                    UserDefaults.standard.set(self.hapticToggle, forKey: "haptic")
                }
                
                // 카페 탐색 범위
                Stepper(value: $stepperAmount,in: 1...300, label: {
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search radius")
                    }
                    Text("\(stepperAmount)m")
                        .fontWeight(.bold)
                }).onChange(of: stepperAmount) { value in
                    
                    UserDefaults.standard.set(self.stepperAmount, forKey: "area")
                }
                
                // 탐색 범위를 벗어난 마커의 지도 표기 유무
                Toggle(isOn: $markersToggle, label: {
                    
                    HStack {
                        Image(systemName: "flag.slash")
                        Text("Markers Out of Zone")
                    }
                }).onChange(of: markersToggle) { value in
                    
                    UserDefaults.standard.set(self.markersToggle, forKey: "markers")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct NNSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NNSettingView(goIndex: .constant(2))
    }
}
