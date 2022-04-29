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
            if UserDefaults.standard.integer(forKey: "area") >= Int(distanceInMeters) {
                //print(String(format: "The distance to my buddy is \(distanceInMeters)m \(marker.title)"))
                return INV_MARKER_IMAGE_BLUE
            }
        }
        return INV_MARKER_IMAGE_GRAY
    }
    
    static func searchInTrkArea(trkDataArray: [TrkData], marker: INVMarker) -> INVImage {
        
        for trk in trkDataArray.enumerated() {
            
            let trkPoint = CLLocation(latitude: trk.element.location.lat, longitude: trk.element.location.lng)
            let markerLocation = CLLocation(latitude: marker.position.lat, longitude: marker.position.lng)
            
            let distanceInMeters = trkPoint.distance(from: markerLocation) // result is in meters
            
            // 범위에 포함되어 있는 마커라면 파란색으로, 벗어난 마커라면 회색으로.
            if UserDefaults.standard.integer(forKey: "area") >= Int(distanceInMeters) {
                //print(String(format: "The distance to my buddy is \(distanceInMeters)m \(marker.title)"))
                return INV_MARKER_IMAGE_BLUE
            }
        }
        return INV_MARKER_IMAGE_GRAY
    }
    
    static func searchShortestDistance(trkArray: [TrkData], marker: INVMarker) -> TrkData? {
        
        var length = UserDefaults.standard.integer(forKey: "area")
        var returnTrk: TrkData? = nil
        
        for trk in trkArray.enumerated() {
            
            let trkPoint = CLLocation(latitude: trk.element.location.lat, longitude: trk.element.location.lng)
            let markerLocation = CLLocation(latitude: marker.position.lat, longitude: marker.position.lng)
            
            let distanceInMeters = trkPoint.distance(from: markerLocation) // result is in meters
            
            if length >= Int(distanceInMeters) {
                //print(String(format: "The distance to my buddy is \(distanceInMeters)m \(marker.title)"))
                length = Int(distanceInMeters)
                returnTrk = trk.element
            }
        }
        return returnTrk
    }
}
