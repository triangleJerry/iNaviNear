//
//  TextInfoWindowDataSource.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/26.
//

import Foundation
import iNaviMaps

// 텍스트를 표출하는 INVImageTextDataSource 클래스
class TextInfoWindowDataSource: NSObject, INVImageTextDataSource {
    func title(with shape: INVShape) -> String {
        
        if let infoWindow = shape as? INVInfoWindow {
            
            return "좌표 : (\(infoWindow.position.lat), \(infoWindow.position.lng))"
        }
        
        return ""
    }
}
