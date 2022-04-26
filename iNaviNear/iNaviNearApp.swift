//
//  iNaviNearApp.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/04.
//

import SwiftUI
import iNaviMaps

@main
struct iNaviNearApp: App {
    
    @State var startIntro: Bool = true
    
    var body: some Scene {
        WindowGroup {
            if startIntro {
                NNIntroView(startIntro: $startIntro)
            } else {
                NNTabView()
            }
        }
    }
    
    init() {
        
        // INVMap 앱키 설정
        INVMapSdk.sharedInstance().appKey = KEY.AppKey
        let userDefaults = UserDefaults.standard
        userDefaults.register(
            defaults: [
                "haptic": true,
                "markers": true,
                "area": 100,
                "bookmark": [String](),
                "cluster": false
            ]
        )
    }
}
