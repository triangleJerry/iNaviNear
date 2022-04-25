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
    var trkArray: [TrkData] = []
    var gridXYArray: [String] = []
    var CafeDataArray: [CafeData] = []
    var circleArray: [INVCircle] = []
    var markerArray: [INVMarker] = []
    var distanceDictionary: [INVMarker : TrkData] = [:]
    var lineArray: [INVPolyline] = []

    private init() {
        
        var filepath = Bundle.main.path(forResource: "LakeLocation", ofType: "gpx")!
        trkArray = gpxParser.parsingLakeLocationGPX(filepath: URL(fileURLWithPath: filepath))!

        filepath = Bundle.main.path(forResource: "CafeLocation", ofType: "gpx")!
        CafeDataArray = gpxParser.parsingCafeLocationGPX(filepath: URL(fileURLWithPath: filepath))!
    }
    
    // 탐색범위를 그려줄 INVCircle 객체들을 일괄적으로 만들어 받아오는 메소드.
    private func getINVcircleArray() -> [INVCircle] {
        
        var INVcircleArray: [INVCircle] = []
        for (index, trk) in trkArray.enumerated() {
            
            if index % 100 == 0 {
                let circle = INVCircle()
                circle.center = trk.location
                circle.radius = Double(UserDefaults.standard.integer(forKey: "area"))
                circle.fillColor = UIColor( cgColor: UIColor(red: 0.90, green: 0.67, blue: 0.64, alpha: 0.30).cgColor )
                circle.strokeWidth = 5 // 원의 테두리 두께를 5pt로 설정
                circle.strokeColor = UIColor(red: 0.83, green: 0.15, blue: 0.19, alpha: 1.00)
                
                INVcircleArray.append(circle)
            }
        }
        
        return INVcircleArray
    }
    
    // 주행경로 <-> 마커 사이의 최단거리 확보를 위한 쌍을 일괄적으로 만들어 오는 메소드.
    private func getLineDictionary() -> [INVMarker:TrkData] {
        
        var _distanceDictionary: [INVMarker:TrkData]  = [:]
        for (_, marker) in markerArray.enumerated() {
            
            let result = SearchingArea.searchShortestDistance(trkArray: trkArray, marker: marker)
            guard result != nil else { continue }
            _distanceDictionary[marker] = result
        }

        return _distanceDictionary
    }
    
    // 최단거리 표시를 위한 INVPolyline 객체들을 일괄적으로 만들어 받아오는 메소드.
    private func getINVPolylineArray() -> [INVPolyline] {
        
        var _polylineArray: [INVPolyline] = []

        for trkAndMarker in distanceDictionary {
            
            let coords = [
                INVLatLng(lat: trkAndMarker.key.position.lat, lng: trkAndMarker.key.position.lng),
                INVLatLng(lat: trkAndMarker.value.location.lat, lng: trkAndMarker.value.location.lng)
            ]
            let polyline = INVPolyline()
            polyline.coords = coords
            polyline.width = 5
            polyline.color = .red
            _polylineArray.append(polyline)
        }
        
        return _polylineArray
    }
    
    
    // 아이나비 지도 위에 마커(카페)들을 그려주기 위해 INVMarker가 담긴 배열을 반환해 주는 메소드.
    private func getINVMarkerArray(mapView: InaviMapView) -> [INVMarker] {
        var _INVMarkerArray: [INVMarker] = []
        
        for item in CafeDataArray.enumerated() {
            
            let marker = INVMarker()
            
            // 마커 커스텀
            marker.position = item.element.location
            marker.iconScale = 0.5
            marker.iconScale += (item.element.star.CGFloatValue()! / 10.0 )
            marker.title = item.element.name
            
            marker.iconImage = INV_MARKER_IMAGE_GRAY
            
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
                        NotificationCenter.default.post(name: Notification.Name.markerInfoWindowEvent, object: marker)
                        return true
                    }
                    infoWindow.marker = marker
                    infoWindow.mapView = mapView
                }
                
                return false
            }
            
            _INVMarkerArray.append(marker)
        }
        return _INVMarkerArray
    }
    
    // 범위 내에 포함되는 마커들의 아이콘 색상을 변경시켜주는 메소드
    private func changeINVMarkerIconImage() {
        
        for marker in markerArray.enumerated() {
            if distanceDictionary[marker.element] != nil {
                marker.element.iconImage = INV_MARKER_IMAGE_BLUE
            }
        }
    }
    
    // 아이나비 지도 위에 셰이프 되어 있는 객체들을 지워주는 메소드. ( 경로 제외 )
    func removeAllMapShapeObjects() {
        
        ShapeUtils.removeINVMarkers(markerArray: markerArray)
        ShapeUtils.removeINVPolylines(lineArray: lineArray)
        
        markerArray = []
        lineArray = []
        distanceDictionary = [:]
        gridXYArray = []
    }
    
    // 아이나비 지도 위에 경로, 탐색범위, 마커를 일괄적으로 셰이프 해주는 메소드.
    func drawMapShapeObjects(mapView: InaviMapView) {
        
        markerArray = getINVMarkerArray(mapView: mapView)
        distanceDictionary = getLineDictionary()
        lineArray = getINVPolylineArray()
        
        changeINVMarkerIconImage() // 최단거리 계산 이후, 포함되는 마커들의 아이콘 이미지를 변경
        
        ShapeUtils.shapeINVRoutes(trkDataArray: trkArray, mapView: mapView)
        ShapeUtils.shapeLines(mapView: mapView, linesArray: lineArray)
        ShapeUtils.shapeINVMarkers(mapView: mapView, markerArray: markerArray)
    }
    
    // MARK: 2번째 방법.
    
    // trkData의 GridXY를 받아오는 메소드
    private func getgridXYArray() -> [String] {
        var _gridXYArray: [String] = []
        
        for (_, item) in trkArray.enumerated() {
            let result = ConvertXY.convertMap(lon: item.location.lng, lat: item.location.lat)
            let str = "\(result.mapX),\(result.mapY)"
            if !_gridXYArray.contains(str) { // 해당 X,Y좌표가 배열에 없을 시, 추가
                _gridXYArray.append(str)
            }
        }
        //print(_gridXYArray, "count:\(_gridXYArray.count), \(UserDefaults.standard.integer(forKey: "area"))m")
        return _gridXYArray
    }
    
    // 범위 내에 포함되는 마커들의 아이콘 색상을 변경시켜주는 메소드
    private func changeINVMarkerIconImageBaseGrid() {
        
        for (_, item) in markerArray.enumerated() {
            let markerGrid = ConvertXY.convertMap(lon: item.position.lng, lat: item.position.lat)
            let str = "\(markerGrid.mapX),\(markerGrid.mapY)"
            if gridXYArray.contains(str) { // 마커와 동일한 그리드에 trkData가 존재하는 경우
                item.iconImage = INV_MARKER_IMAGE_BLUE
                continue
            }
            
            item.iconImage = SearchingArea.searchInTrkArea(trkDataArray: trkArray, marker: item)
        }
    }
    
    func drawMapShapeObjectsOptimization(mapView: InaviMapView) {
        
        markerArray = getINVMarkerArray(mapView: mapView)
        gridXYArray = getgridXYArray()
        changeINVMarkerIconImageBaseGrid()
        
        ShapeUtils.shapeINVRoutes(trkDataArray: trkArray, mapView: mapView)
        ShapeUtils.shapeINVMarkers(mapView: mapView, markerArray: markerArray)
    }
}
