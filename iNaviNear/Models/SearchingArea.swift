//
//  SearchingArea.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/12.
//

import Foundation
import iNaviMaps

class SearchingArea {
    
    // 영역 범위 내에 포함된 마커를 찾아주는 메소드.
    static func searchInAreaMarker(circleArray: [INVCircle], marker: INVMarker) -> INVImage {

        for circle in circleArray.enumerated() {
            let circleCenter = CLLocation(latitude: circle.element.center.lat, longitude: circle.element.center.lng)
            let markerLocation = CLLocation(latitude: marker.position.lat, longitude: marker.position.lng)
            
            let distanceInMeters = circleCenter.distance(from: markerLocation) // result is in meters
            
            // 범위에 포함되어 있는 마커라면 파란색으로, 벗어난 마커라면 회색으로.
            if UserDefaults.standard.integer(forKey: "area") >= Int(distanceInMeters) { // 탐색 범위 밖의 마커들
                print(String(format: "The distance to my buddy is \(distanceInMeters)m \(marker.title)"))
                return INV_MARKER_IMAGE_BLUE
            }
        }
        return INV_MARKER_IMAGE_GRAY
    }
}
