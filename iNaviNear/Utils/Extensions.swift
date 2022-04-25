//
//  Extensions.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import UIKit
import SwiftUI

class Timestamp {
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS "
        return formatter
    }()

    func printTimestamp() {
        print(dateFormatter.string(from: Date()))
    }
}

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
    
    static let bookMarkClickEvent = Notification.Name("bookMarkClickEvent")
}

extension View {
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               config: Toast.Config) -> some View {
        
        self.modifier(Toast(message: message, config: config, isShowing: isShowing))
    }
    
    func toast(message: String,
               isShowing: Binding<Bool>,
               duration: TimeInterval) -> some View {
        
        self.modifier(Toast(message: message, config: .init(duration: duration), isShowing: isShowing))
    }
}
