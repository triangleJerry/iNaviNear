//
//  Extensions.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import UIKit
import SwiftUI

extension String {

  func CGFloatValue() -> CGFloat? {
    guard let doubleValue = Double(self) else {
      return nil
    }

    return CGFloat(doubleValue)
  }
}

extension Notification.Name {
    
    static let markerInfoWindowEvent = Notification.Name("markerInfoWindowEvent")
}

extension View {
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config) -> some View {
        self.modifier(Toast(message: message, isShowing: isShowing, config: config))
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               duration: TimeInterval) -> some View {
        self.modifier(Toast(message: message, isShowing: isShowing, config: .init(duration: duration)))
    }
}
