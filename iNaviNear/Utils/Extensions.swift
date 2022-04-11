//
//  Extensions.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import UIKit

extension String {

  func CGFloatValue() -> CGFloat? {
    guard let doubleValue = Double(self) else {
      return nil
    }

    return CGFloat(doubleValue)
  }
}
