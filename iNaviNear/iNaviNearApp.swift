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
    
    
    init() {
        // INVMap 앱키 설정
        INVMapSdk.sharedInstance().appKey = KEY.AppKey
        let userDefaults = UserDefaults.standard
        userDefaults.register(
            defaults: [
                "sounds": true,
                "markers": true,
                "area": 100,
                "bookmark": [String]()
            ]
        )
    }
    
    var body: some Scene {
        WindowGroup {
            NNTabView()
        }
    }
}
