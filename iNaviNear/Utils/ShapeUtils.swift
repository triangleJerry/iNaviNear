//
//  ShapeUtils.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/07.
//

import Foundation
import UIKit
import iNaviMaps

class ShapeUtils {
    
    // 아이나비 지도 위에 루트를 그려주기 위해 객체 INVRoute를 만들어 반환해 주는 메소드.
    static func shapeINVRoutes(trkDataArray: [TrkData], mapView: InaviMapView) {
        
        var latlng: [INVLatLng] = []
        
        for trkdata in trkDataArray {
            latlng.append(trkdata.location)
        }
        
        let link = INVRouteLink(coords: latlng, lineColor: UIColor(red: 0.38, green: 0.78, blue: 0.61, alpha: 1.00))
        let route = INVRoute(links: [link])
        route.lineWidth = 8
        route.patternMargin = 12
        route.patternImage = INVImage(name: "inv_pattern_arrow")

        route.mapView = mapView
    }
    
    // 아이나비 지도 위에 원형 범위를 그려주는 메소드. (현재 로직: 100개의 포인트마다 한 번씩 추적)
    static func shapeCircleRanges(trkDataArray: [TrkData], mapView: InaviMapView, circleArray: inout [INVCircle]) {
        circleArray = []
        
        for (index, item) in trkDataArray.enumerated() {
            if index % 100 == 0 {
                let circle = INVCircle()
                circle.center = item.location
                circle.radius = Double(UserDefaults.standard.integer(forKey: "area"))
                circle.fillColor = UIColor( cgColor: UIColor(red: 0.90, green: 0.67, blue: 0.64, alpha: 0.30).cgColor )
                circle.strokeWidth = 5 // 원의 테두리 두께를 5pt로 설정
                circle.strokeColor = UIColor(red: 0.83, green: 0.15, blue: 0.19, alpha: 1.00)
                
                circle.mapView = mapView
                circleArray.append(circle)
            }
        }
    }
    
    
    // 아이나비 지도 위의 원형 범위들을 일괄적으로 지워주는 메소드.
    static func removeCircleRanges(circleArray: inout [INVCircle]) {
        for circle in circleArray.enumerated() {
            circle.element.mapView = nil
        }
        circleArray = []
    }
    
    // 아이나비 지도 위의 원형 범위들을 일괄적으로 지워주는 메소드.
    static func removeINVMarkers(markerArray: inout [INVMarker]) {
        for marker in markerArray.enumerated() {
            marker.element.mapView = nil
        }
        markerArray = []
    }
    
    // 아이나비 지도 위에 마커(카페)들을 그려주기 위해 INVMarker가 담긴 배열을 반환해 주는 메소드.
    static func shapeINVMarkers(markerDictionary: [String:CafeData], mapView: InaviMapView, circleArray: inout [INVCircle], markerArray: inout [INVMarker]) {
        markerArray = []
        
        for item in markerDictionary.values.enumerated() {
            let marker = INVMarker()
            
            // 마커 커스텀
            marker.position = item.element.location
            marker.iconScale = 0.5
            marker.iconScale += (item.element.star.CGFloatValue()! / 10.0 )
            marker.title = item.element.name
            marker.iconImage = SearchingArea.searchInAreaMarker(circleArray: circleArray, marker: marker)
            
            marker.touchEvent = { (shape) in
                HapticManager.instance.impact(style: .medium)
                if marker.infoWindow != nil {
                    // 정보 창이 마커 위에 표출되고 있는 경우
                    marker.infoWindow!.mapView = nil
                    marker.infoWindow?.marker = nil
                } else {
                    // 정보 창이 마커 위에 표출되지 않고 있는 경우
                    let infoWindow = INVInfoWindow()
                    let textInfoWindowDataSource = TextInfoWindowDataSource()
                    
                    infoWindow.position = item.element.location
                    infoWindow.imageDataSource = textInfoWindowDataSource
                    
                    // 즐겨찾기를 등록할지의 여부를 묻는 Alert 팝업.
                    infoWindow.touchEvent = { (shape) in
                        HapticManager.instance.impact(style: .medium)
                        NotificationCenter.default.post(name: Notification.Name.markerInfoWindowEvent, object: nil)
                        return true
                    }
                    infoWindow.marker = marker
                    infoWindow.mapView = mapView
                }
                
                return false
            }
            
            marker.mapView = mapView
            markerArray.append(marker)
        }
    }
}

// 텍스트를 표출하는 INVImageTextDataSource 클래스
class TextInfoWindowDataSource: NSObject, INVImageTextDataSource {
    func title(with shape: INVShape) -> String {
        if let infoWindow = shape as? INVInfoWindow {
            return "좌표 : (\(infoWindow.position.lat), \(infoWindow.position.lng))"
        }
        return ""
    }
}
