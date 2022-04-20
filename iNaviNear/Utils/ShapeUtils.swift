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
    
    // MARK: iNaviMaps Shape Objects func.
    
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
    
    // 아이나비 지도 위에 원형 범위를 셰이프 해주는 메소드.
    static func shapeCircleRanges(mapView: InaviMapView, circleArray: [INVCircle]) {
        
        for circle in circleArray.enumerated() {
            
            circle.element.mapView = mapView
        }
    }
    
    // 아이나비 지도 위에 최단 거리( 직선 )를 셰이프 해주는 메소드.
    static func shapeLines(mapView: InaviMapView, linesArray: [INVPolyline]) {
        
        for line in linesArray.enumerated() {
            
            line.element.mapView = mapView
        }
    }
    
    // 아이나비 지도 위에 마커(카페)들을 셰이프 해주는 메소드.
    static func shapeINVMarkers(mapView: InaviMapView, markerArray: [INVMarker]) {
        
        for marker in markerArray.enumerated() {
            
            if UserDefaults.standard.bool(forKey: "markers") == false
                && marker.element.iconImage == INV_MARKER_IMAGE_GRAY {
                continue
            }
            marker.element.mapView = mapView
        }
    }
    
    // 아이나비 지도 위에 최단거리들을 셰이프 해주는 메소드.
    static func shapeINVPolylines(mapView: InaviMapView, lineArray: [INVPolyline]) {
        
        for line in lineArray.enumerated() {

            line.element.mapView = mapView
        }
    }
    
    // 범위 내에 포함되는 마커들의 아이콘 색상을 변경시켜주는 메소드
    static func changeINVMarkerIconImage(markerArray: [INVMarker], distanceDictionary: [INVMarker:TrkData]) {
        
        for marker in markerArray.enumerated() {
            
            if distanceDictionary[marker.element] != nil {
                marker.element.iconImage = INV_MARKER_IMAGE_BLUE
            }
        }
    }
    
    // MARK: iNaviMaps remove Objects func.
    
    // 아이나비 지도 위의 원형 탐색 범위들을 일괄적으로 지워주는 메소드.
    static func removeCircleRanges(circleArray: [INVCircle]) {
        for circle in circleArray.enumerated() {
            
            circle.element.mapView = nil
        }
    }
    
    // 아이나비 지도 위의 마커(카페)들을 일괄적으로 지워주는 메소드.
    static func removeINVMarkers(markerArray: [INVMarker]) {
        for marker in markerArray.enumerated() {
            
            marker.element.infoWindow?.mapView = nil
            marker.element.mapView = nil
        }
    }
    
    // 아이나비 지도 위의 최단거리 선들을 일괄적으로 지워주는 메소드.
    static func removeINVPolylines(lineArray: [INVPolyline]) {
        for line in lineArray.enumerated() {
            
            line.element.mapView = nil
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
