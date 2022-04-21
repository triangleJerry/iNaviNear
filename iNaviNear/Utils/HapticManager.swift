//
//  HapticManager.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/12.
//

import Foundation
import UIKit

class HapticManager {
    
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        let haptic =  UserDefaults.standard.bool(forKey: "haptic")
        if haptic {
            let generator = UIImpactFeedbackGenerator(style: style)
            generator.impactOccurred()
        }
    }
}
