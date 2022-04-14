//
//  ShapeObjectsBundle.swift
//  iNaviNear
//
//  Created by 장은석 on 2022/04/14.
//

import Foundation
import iNaviMaps

// 지도에 그려질 오브젝트(경로, 원, 마커)들의 인스턴스를 가지고 있는 싱글톤 패턴의 클래스입니다.
class ShapeObjectsBundle {
    
    static let shared = ShapeObjectsBundle()
    
    let gpxParser = GPXParser()
    var circleArray: [INVCircle] = []
    var markerArray: [INVMarker] = []
    var trkArray: [TrkData] = []
    var cafeDic: [String:CafeData] = [:]
    
    private init() {
        
        var filepath = Bundle.main.path(forResource: "LakeLocation", ofType: "gpx")!
        trkArray = gpxParser.parsingLakeLocationGPX(filepath: URL(fileURLWithPath: filepath))!

        filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        cafeDic = gpxParser.parsingCafeLocationGPX(filepath: URL(fileURLWithPath: filepath))!
    }
    
    func removeAllMapShapeObjects() {
        
        ShapeUtils.removeCircleRanges(circleArray: &circleArray)
        ShapeUtils.removeINVMarkers(markerArray: &markerArray)
    }
    
    
    func drawMapShapeObjects(mapView: InaviMapView) {
        
        ShapeUtils.shapeINVRoutes(trkDataArray: trkArray, mapView: mapView)
        ShapeUtils.shapeCircleRanges(trkDataArray: trkArray, mapView: mapView, circleArray: &circleArray)
        ShapeUtils.shapeINVMarkers(markerDictionary: cafeDic, mapView: mapView, circleArray: &circleArray, markerArray: &markerArray)
    }
}
